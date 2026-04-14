#!/bin/sh
# This script compares ABI compatibility between two versions of packages
# by running abipkgdiff on RPM packages from Fedora repository (directory /a/)
# and ROCm COPR preview repository (directory /b/). It uses debuginfo and devel
# packages from both directories for comprehensive analysis. Output is written to
# test.log file.

debuginfo_a=`ls a/*-debuginfo-*`
debuginfo_b=`ls b/*-debuginfo-*`
devel_a=`ls a/*-devel-*`
devel_b=`ls b/*-devel-*`
a=${devel_a//"-devel"/}
b=${devel_b//"-devel"/}

abipkgdiff $a $b \
	   --devel1 $devel_a --devel2 $devel_b \
	   --d1 $debuginfo_a --d2 $debuginfo_b 2>&1 | tee test.log
