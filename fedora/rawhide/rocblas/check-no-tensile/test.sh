#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log
/usr/bin/rocblas-test 2>&1 | tee -a /test.log

echo "use docker cp <foo>:/test.log ."
bash

