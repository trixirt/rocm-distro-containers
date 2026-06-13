#!/bin/sh

date
uname -a
rocminfo
for f in /usr/bin/test_rocrand*; do
    $f 2>&1 | tee -a /test.log
done

echo "use docker cp:<foo> /test.log ."
bash

