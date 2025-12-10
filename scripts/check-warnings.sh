#!/bin/sh

echo "Uninitialized variable warnings"
grep 'note: initialize the variable' $1 | sort -u

