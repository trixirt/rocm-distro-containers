#!/bin/sh

debuginfo_a=`ls a/*-debuginfo-*`
debuginfo_b=`ls b/*-debuginfo-*`
devel_a=`ls a/*-devel-*`
devel_b=`ls b/*-devel-*`
a=`echo -n $devel_a | sed 's/-devel//'`
b=`echo -n $devel_b | sed 's/-devel//'`

abipkgdiff $a $b \
	   --devel1 $devel_a --devel2 $devel_b \
	   --d1 $debuginfo_a --d2 $debuginfo_b 2>&1 | tee test.log
