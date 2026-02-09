#!/bin/sh

export HIP_PATH=`hipconfig -p`
export ROCM_PATH=`hipconfig -R`
export HIP_CLANG_PATH=`hipconfig -l`
gpu=`rocm_agent_enumerator | grep -v gfx000 -m1`

cd rocm-systems/projects/hip-tests

mkdir build
cd build
cmake -G Ninja -S ${PWD}/../catch \
      -DCLANG_CPP_EXEC=${HIP_CLANG_PATH}/clang-cpp \
      -DCMAKE_INSTALL_PREFIX=$PWD \
      -DCMAKE_CXX_COMPILER=${HIP_CLANG_PATH}/clang++ \
      -DCMAKE_EXE_LINKER_FLAGS="-lamdhip64" \
      -DCMAKE_AR=${HIP_CLANG_PATH}/llvm-ar \
      -DCMAKE_RANLIB=${HIP_CLANG_PATH}/llvm-ranlib \
      -DHIP_PLATFORM=amd \
      -DROCM_PATH=/usr 

ninja
bash
