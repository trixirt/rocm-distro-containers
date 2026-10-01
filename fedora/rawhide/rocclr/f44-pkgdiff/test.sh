#!/bin/sh
# This script compares ABI compatibility between two versions of packages
# by running abipkgdiff on RPM packages from Fedora repository (directory /a/)
# and ROCm COPR preview repository (directory /b/). It uses debuginfo and devel
# packages from both directories for comprehensive analysis. Output is written to
# test.log file.

mkdir /output

debuginfo_a=`ls a/*-debuginfo-*`
debuginfo_b=`ls b/*-debuginfo-*`
devel_a=`ls a/*-devel-*`
devel_b=`ls b/*-devel-*`
a=${devel_a//"-devel"/}
b=${devel_b//"-devel"/}

echo "== abipkgdiff == " 2>&1 | tee /output/test.log
abipkgdiff $a $b \
	   --devel1 $devel_a --devel2 $devel_b \
	   --d1 $debuginfo_a --d2 $debuginfo_b 2>&1 | tee -a /output/test.log

echo "" 2>&1 | tee -a /output/test.log
echo "== rpmlint == " 2>&1 | tee -a /output/test.log
cd a
af=`basename $a`
rpmlint $af 2>&1 > ${af}.rpmlint
cd ..
cd b
bf=`basename $b`
rpmlint $bf 2>&1 > ${bf}.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a /output/test.log
diff ${a}.rpmlint ${b}.rpmlint 2>&1 | tee -a /output/test.log

cd a
af=`basename $devel_a`
rpmlint $af 2>&1 > ${af}.rpmlint
cd ..
cd b
bf=`basename $devel_b`
rpmlint $bf 2>&1 > ${bf}.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a /output/test.log
diff ${devel_a}.rpmlint ${devel_b}.rpmlint 2>&1 | tee -a /output/test.log

echo "" 2>&1 | tee -a /output/test.log
echo "== rpm -ql, manifest == " 2>&1 | tee -a /output/test.log

cd a
af=`basename $a`
rpm -qlp $af 2>&1 > ${af}.manifest
cd ..
cd b
bf=`basename $b`
rpm -qlp $bf 2>&1 > ${bf}.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a /output/test.log
diff ${a}.manifest ${b}.manifest 2>&1 | tee -a /output/test.log

cd a
af=`basename $devel_a`
rpm -qlp $af 2>&1 > ${af}.manifest
cd ..
cd b
bf=`basename $devel_b`
rpm -qlp $bf 2>&1 > ${bf}.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a /output/test.log
diff ${devel_a}.manifest ${devel_b}.manifest 2>&1 | tee -a /output/test.log

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
