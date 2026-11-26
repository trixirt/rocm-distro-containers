#!/bin/sh
set -x

export HIP_PATH=$(hipconfig -p)
export ROCM_PATH=$(hipconfig -R)
export HIP_CLANG_PATH=$(hipconfig -l)
gpu=$(rocm_agent_enumerator | grep -v gfx000 -m1)
export PATH="/usr/lib64/rocm/llvm/bin:$PATH"

cd projects/hipfile

rm -rf build
mkdir -p build
cd build

cmake .. \
  -G Ninja \
  -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
  -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
  -DBUILD_TESTING=ON \
  -DROCM_VERSION=10.2.0 \
  -DHIPFILE_ROCPROFILER_REGISTER=ON \
  -DHIPFILE_INSTALL_EXAMPLES=ON

if [ -f build.ninja ]; then
  ninja
  ctest --output-on-failure
else
  echo "failed to build"
  exit 1
fi
