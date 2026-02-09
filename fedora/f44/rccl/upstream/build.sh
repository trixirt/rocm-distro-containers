#!/bin/sh

export HIP_PATH=`hipconfig -p`
export ROCM_PATH=`hipconfig -R`
export HIP_CLANG_PATH=`hipconfig -l`
gpu=`rocm_agent_enumerator | grep -v gfx000 -m1`

# cd rocm-systems/projects/rccl
cd rccl

# wrong path
# https://github.com/ROCm/rccl/issues/1649
sed -i -e 's@rocm-core/rocm_version.h@rocm_version.h@' src/include/hip_rocm_version_info.h

# Too many parallel links to do more than 1
sed -i -e "s@-parallel-jobs=\${num_linker_jobs}@-parallel-jobs=1@" CMakeLists.txt

# To remove falsely counting compile jobs, also set to 1
sed -i -e "s@rccl PRIVATE -parallel-jobs=12@rccl PRIVATE -parallel-jobs=1@" CMakeLists.txt

mkdir build
cd build
cmake -G Ninja -S .. \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$PWD \
      -DCMAKE_CXX_COMPILER=${HIP_CLANG_PATH}/clang++ \
      -DENABLE_MSCCLPP=OFF \
      -DEXPLICIT_ROCM_VERSION=7.1.1 \
      -DGPU_TARGETS="gfx1100" \
      -DHIP_PLATFORM=amd \
      -DRCCL_ROCPROFILER_REGISTER=OFF \
      -DROCM_PATH=/usr 

/usr/bin/time -v ninja -j 1

