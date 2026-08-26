#!/bin/sh

export ROCM_PATH=/usr
export ROCTRACER_LIB_PATH=/usr/lib64
export ROCTRACER_TOOL_PATH=/usr/lib64/roctracer

/usr/share/roctracer/run_tests.sh
