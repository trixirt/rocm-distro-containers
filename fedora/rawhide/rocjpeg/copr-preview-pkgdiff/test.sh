#!/bin/sh
# This script compares ABI compatibility and package integrity between two versions
# of RPM packages from a local Fedora repository (/a/) and a COPR repo (/b/).
# It leverages debuginfo and devel packages for thorough analysis. All output is logged
# to /output/test.log, with individual results saved in /output/.

set -x

mkdir /output

# Get full paths to debuginfo and devel packages
debuginfo_a=`ls a/*-debuginfo-*`
debuginfo_b=`ls b/*-debuginfo-*`
devel_a=`ls a/*-devel-*`
devel_b=`ls b/*-devel-*`

# Strip "-devel" suffix from devel paths to get the standard package RPM path
a=${devel_a//"-devel"/}
b=${devel_b//"-devel"/}

# Construct corresponding source RPM paths by replacing .x86_64.rpm with .src.rpm
src_a=${a//".x86_64.rpm"/}.src.rpm
src_b=${b//".x86_64.rpm"/}.src.rpm

# ---------------------------------------------------------
# SECTION 1: ABI Compatibility Check (abipkgdiff)
# Compares binaries and libraries using debuginfo and devel packages
# ---------------------------------------------------------
echo "== abipkgdiff == " 2>&1 | tee /output/test.log
abipkgdiff $a $b \
	   --devel1 $devel_a --devel2 $devel_b \
	   --d1 $debuginfo_a --d2 $debuginfo_b 2>&1 | tee /output/test.log

# ---------------------------------------------------------
# SECTION 2: RPM Spec & Content Lints (Main Package)
# ---------------------------------------------------------
echo "" 2>&1 | tee -a /output/test.log
echo "== rpmlint == " 2>&1 | tee -a /output/test.log
cd a
af=`basename $a`
rpmlint $af 2>&1 > /output/a.rpmlint
cd ..
cd b
bf=`basename $b`
rpmlint $bf 2>&1 > /output/b.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.rpmlint /output/b.rpmlint 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 3: RPM Spec & Content Lints (Devel Package)
# ---------------------------------------------------------
cd a
af=`basename $devel_a`
rpmlint $af 2>&1 > /output/a.devel.rpmlint
cd ..
cd b
bf=`basename $devel_b`
rpmlint $bf 2>&1 > /output/b.devel.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.devel.rpmlint /output/b.devel.rpmlint 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 4: RPM Spec & Content Lints (Source Package)
# ---------------------------------------------------------
cd a
af=`basename $src_a`
rpmlint $af 2>&1 > /output/a.src.rpmlint
cd ..
cd b
bf=`basename $src_b`
rpmlint $bf 2>&1 > /output/b.src.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.src.rpmlint /output/b.src.rpmlint 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 5: Source Package Inspection (rpminspect)
# Validates source package against Fedora guidelines
# ---------------------------------------------------------
echo "" 2>&1 | tee -a /output/test.log
echo "== rpminspect == " 2>&1 | tee -a /output/test.log
cd a
af=`basename $src_a`
rpminspect -c /usr/share/rpminspect/fedora.yaml $af 2>&1 > /output/a.rpminspect
cd ..
cd b
bf=`basename $src_b`
rpminspect -c /usr/share/rpminspect/fedora.yaml $bf 2>&1 > /output/b.rpminspect
cd ..
echo "diff of rpminspect for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.rpminspect /output/b.rpminspect 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 6: Manifest Comparison (Main Package)
# Lists and diffs installed files for the main package
# ---------------------------------------------------------
echo "" 2>&1 | tee -a /output/test.log
echo "== rpm -ql, manifest == " 2>&1 | tee -a /output/test.log

cd a
af=`basename $a`
rpm -qlp $af 2>&1 > /output/a.manifest
cd ..
cd b
bf=`basename $b`
rpm -qlp $bf 2>&1 > /output/b.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.manifest /output/b.manifest 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 7: Manifest Comparison (Devel Package)
# Lists and diffs installed files for the devel package
# ---------------------------------------------------------
cd a
af=`basename $devel_a`
rpm -qlp $af 2>&1 > /output/a.devel.manifest
cd ..
cd b
bf=`basename $devel_b`
rpm -qlp $bf 2>&1 > /output/b.devel.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.devel.manifest /output/b.devel.manifest 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 8: Manifest Comparison (Source Package)
# ---------------------------------------------------------
cd a
af=`basename $src_a`
rpm -qlp $af 2>&1 > /output/a.src.manifest
cd ..
cd b
bf=`basename $src_b`
rpm -qlp $bf 2>&1 > /output/b.src.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a /output/test.log
diff /output/a.src.manifest /output/b.src.manifest 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 9: Specfile Extraction & Comparison
# Extracts and diffs the specfiles from both source RPMs
# ---------------------------------------------------------
echo "" 2>&1 | tee -a /output/test.log
echo "== specfile == " 2>&1 | tee -a /output/test.log
cd a
af=`basename $src_a`
sf=${af%%-*}
rpm2cpio $af | cpio -idmv
cd ..
cd b
bf=`basename $src_b`
rpm2cpio $bf | cpio -idmv
cd ..
echo "diff of specfile $bf" 2>&1 | tee -a /output/test.log
diff -u a/${sf}.spec b/${sf}.spec 2>&1 | tee -a /output/test.log

# ---------------------------------------------------------
# SECTION 10: ABI Dump & Compliance Check
# Dumps ABI signatures and checks for breaking changes
# ---------------------------------------------------------
echo "" 2>&1 | tee -a /output/test.log
echo "== abi compliance == " 2>&1 | tee -a /output/test.log
cd a
for f in `ls *.x86_64.rpm`; do
    rpm2cpio $f | cpio -idmv
done
cd ..
cd b
for f in `ls *.x86_64.rpm`; do
    rpm2cpio $f | cpio -idmv
done
cd ..

# Generalized ABI Analysis Loop
for so_file in /a/usr/lib64/*.so; do
    [ -e "$so_file" ] || continue
    lib_name=$(basename "$so_file")
    lib_name=${lib_name#lib}
    lib_name=${lib_name%.so*}

    old_lib="/a/usr/lib64/lib${lib_name}.so"
    new_lib="/b/usr/lib64/lib${lib_name}.so"

    echo -e "\n--- Checking ABI for: ${lib_name} ---" 2>&1 | tee -a /output/test.log

    if [ ! -f "$new_lib" ]; then
        echo "   SKIPPED: ${new_lib} not found in /b/." 2>&1 | tee -a /output/test.log
        continue
    fi

    echo "   Dumping old ABI..." 2>&1 | tee -a /output/test.log
    abi-dumper "$old_lib" \
        --search-debuginfo="/a/usr/lib/debug/usr/lib64/" \
        -o "/output/${lib_name}.a.abi-dump.dump" \
        -lver 0 2>&1 | tee -a /output/test.log

    echo "   Dumping new ABI..." 2>&1 | tee -a /output/test.log
    abi-dumper "$new_lib" \
        --search-debuginfo="/b/usr/lib/debug/usr/lib64/" \
        -o "/output/${lib_name}.b.abi-dump.dump" \
        -lver 0 2>&1 | tee -a /output/test.log

    echo "   Generating report..." 2>&1 | tee -a /output/test.log
    abi-compliance-checker -lib "$lib_name" \
        -old "/output/${lib_name}.a.abi-dump.dump" \
        -new "/output/${lib_name}.b.abi-dump.dump" \
        -report-path "/output/${lib_name}.abi_report.html" 2>&1 | tee -a /output/test.log
done
