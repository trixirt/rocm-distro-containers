#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log

for f in /usr/bin/test_*; do
    $f 2>&1 | tee -a /test.log
done

echo "use docker cp <foo>:/test.log ."
bash

