#!/bin/sh
# This script compares ABI compatibility between two versions of packages
# by running abipkgdiff on RPM packages from Fedora repository (directory /a/)
# and ROCm COPR preview repository (directory /b/). It uses debuginfo and devel
# packages from both directories for comprehensive analysis. Output is written to
# test.log file.

devel_a=`ls a/*-devel-*`
devel_b=`ls b/*-devel-*`
src_a=`ls a/*.src.rpm`
src_b=`ls b/*.src.rpm`

echo "== abipkgdiff == " 2>&1 | tee test.log
abipkgdiff $devel_a $devel_b \
	   2>&1 | tee test.log

echo "" 2>&1 | tee -a test.log
echo "== rpmlint == " 2>&1 | tee -a test.log

cd a
af=`basename $devel_a`
rpmlint $af 2>&1 > ${af}.rpmlint
cd ..
cd b
bf=`basename $devel_b`
rpmlint $bf 2>&1 > ${bf}.rpmlint
cd ..
echo "diff of rpmlint for $bf" 2>&1 | tee -a test.log
diff ${devel_a}.rpmlint ${devel_b}.rpmlint 2>&1 | tee -a test.log

cd a
af=`basename $src_a`
rpmlint $af 2>&1 > ${af}.rpmlint
cd ..
cd b
bf=`basename $src_b`
rpmlint $bf 2>&1 > ${bf}.rpmlint
cd ..
echo "diff of rpm lint for $bf" 2>&1 | tee -a test.log
diff ${src_a}.rpmlint ${src_b}.rpmlint 2>&1 | tee -a test.log

echo "" 2>&1 | tee -a test.log
echo "== rpminspect == " 2>&1 | tee -a test.log
cd a
af=`basename $src_a`
rpminspect -c /usr/share/rpminspect/fedora.yaml $af 2>&1 > ${af}.rpminspect
cd ..
cd b
bf=`basename $src_b`
rpminspect -c /usr/share/rpminspect/fedora.yaml $bf 2>&1 > ${bf}.rpminspect
cd ..
echo "diff of rpminspect for $bf" 2>&1 | tee -a test.log
diff ${src_a}.rpminspect ${src_b}.rpminspect 2>&1 | tee -a test.log

echo "" 2>&1 | tee -a test.log
echo "== rpm -ql, manifest == " 2>&1 | tee -a test.log

cd a
af=`basename $a`
rpm -qlp $af 2>&1 > ${af}.manifest
cd ..
cd b
bf=`basename $b`
rpm -qlp $bf 2>&1 > ${bf}.manifest
cd ..
echo "diff of manifest for $bf" 2>&1 | tee -a test.log
diff ${a}.manifest ${b}.manifest 2>&1 | tee -a test.log

cd a
af=`basename $src_a`
rpm -qlp $af 2>&1 > ${af}.manifest
cd ..
cd b
bf=`basename $src_b`
rpm -qlp $bf 2>&1 > ${bf}.manifest
cd ..
echo "diff of rpm lint for $bf" 2>&1 | tee -a test.log
diff ${src_a}.manifest ${src_b}.manifest 2>&1 | tee -a test.log

echo "" 2>&1 | tee -a test.log
echo "== specfile == " 2>&1 | tee -a test.log
cd a
af=`basename $src_a`
sf=${af%%-*}
rpm2cpio $af | cpio -idmv
cd ..
cd b
bf=`basename $src_b`
rpm2cpio $bf | cpio -idmv
cd ..
echo "diff of specfile $bf" 2>&1 | tee -a test.log
diff -u a/${sf}.spec b/${sf}.spec 2>&1 | tee -a test.log
