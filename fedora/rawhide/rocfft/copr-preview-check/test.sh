#!/bin/sh

date | tee -a /test.log
uname -a | tee -a /test.log
rocminfo | tee -a /test.log
/usr/bin/rocfft-test 2>&1 | tee -a /test.log

echo "use docker cp <foo>:/test.log ."
bash

