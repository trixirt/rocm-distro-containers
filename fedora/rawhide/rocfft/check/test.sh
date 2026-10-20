#!/bin/sh

date
uname -a
rocminfo
/usr/bin/rocfft-test 2>&1 | tee -a /test.log


