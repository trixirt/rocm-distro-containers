#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log
/usr/bin/hipfft-test 2>&1 | tee -a /test.log


