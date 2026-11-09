#!/bin/sh
set -e
set -x

export HIP_PATH=$(hipconfig -p)
export ROCM_PATH=$(hipconfig -R)
export HIP_CLANG_PATH=$(hipconfig -l)
gpu=$(rocm_agent_enumerator | grep -v gfx000 -m1)

export PATH="/usr/lib64/rocm/llvm/bin:$PATH"

cd /rocm-libraries/projects/hiptensor
rm -rf build
mkdir -p build
cd build

cmake .. \
  -G Ninja \
  -DAMDGPU_TARGETS=$gpu \
  -DHIPTENSOR_BUILD_TESTS=ON \
  -DHIPTENSOR_BUILD_SAMPLES=ON \
  -DCMAKE_AR=/usr/lib64/rocm/llvm/bin/llvm-ar \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
  -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
  -DCMAKE_INSTALL_PREFIX=$PWD/install \
  -DCMAKE_LINKER=/usr/lib64/rocm/llvm/bin/ld.lld \
  -DCMAKE_RANLIB=/usr/lib64/rocm/llvm/bin/llvm-ranlib

if [ -f build.ninja ]; then
  ninja
  ctest --output-on-failure
else
  echo "failed to build"
  exit 1
fi
