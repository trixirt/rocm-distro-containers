#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log
rpm -qli rccl-test    2>&1 | tee -a /test.log

for f in /usr/bin/rccl-Unit*; do
    $f 2>&1 | tee -a /test.log
done


