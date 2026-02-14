#!/bin/sh

export CUPY_INSTALL_NO_RPATH=1
export CUPY_INSTALL_USE_STUB=0
export CUPY_INSTALL_USE_HIP=1
export ROCM_HOME=/usr
export HCC_AMDGPU_TARGET=gfx1100
export CXX=/usr/lib64/rocm/llvm/bin/amdclang++
export CC=/usr/lib64/rocm/llvm/bin/amdclang

cd cupy

# Use hipcc
sed -i -e "s@backend = 'hiprtc' if backend == 'nvrtc' else 'hipcc'@backend = 'hipcc'@" cupy/cuda/compiler.py

pip install . 2>&1 | tee build.log
