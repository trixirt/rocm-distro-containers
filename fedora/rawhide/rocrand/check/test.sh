#!/bin/sh

date
uname -a
rocminfo
for f in /usr/bin/test_rocrand*; do
    $f 2>&1 | tee -a /test.log
done

# Clean up the log: remove ANSI escape codes and GTest boilerplate (e.g., "Running main", "Global test environment")
if [ -f /test.log ]; then
    sed 's/\x1B\[[0-9;]*[a-zA-Z]//g' /test.log | grep -v "Running main\|Global test environment" > /tmp/clean_test.log
    mv /tmp/clean_test.log /test.log
fi

echo "use docker cp:<foo> /test.log ."
bash

