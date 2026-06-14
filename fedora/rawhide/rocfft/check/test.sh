#!/bin/sh

date
uname -a
rocminfo
/usr/bin/rocfft-test 2>&1 | tee -a /test.log

echo "use docker cp <foo>:/test.log ."
bash

