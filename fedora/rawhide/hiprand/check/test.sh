#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log

for f in /usr/bin/test_hiprand*; do
    $f 2>&1 | tee -a /test.log
done



