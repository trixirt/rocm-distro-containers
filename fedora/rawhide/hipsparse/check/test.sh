#!/bin/sh

date                  2>&1 | tee -a /test.log
uname -a              2>&1 | tee -a /test.log
rocminfo              2>&1 | tee -a /test.log
/usr/bin/hipsparse-test 2>&1 | tee -a /test.log


