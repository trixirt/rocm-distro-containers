#!/bin/sh
set -e

cd rocm-libraries/shared/primbench/examples

hipcc -o copy_benchmark copy_benchmark.cpp -lamd_smi -lamdhip64
./copy_benchmark

