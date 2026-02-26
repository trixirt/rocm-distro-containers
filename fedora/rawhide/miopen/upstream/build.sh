#!/bin/sh

export HIP_PATH=`hipconfig -p`
export ROCM_PATH=`hipconfig -R`
export HIP_CLANG_PATH=`hipconfig -l`
gpu=`rocm_agent_enumerator | grep -v gfx000 -m1`

# clang-tidy is brittle and not needed for rebuilding from a tarball
sed -i -e 's@clang-tidy@true@' cmake/ClangTidy.cmake

# workaround error on finding lbunzip2
sed -i -e 's@lbunzip2 bunzip2@bunzip2@' CMakeLists.txt

# https://github.com/ROCm/MIOpen/issues/2672
sed -i -e 's@find_path(HALF_INCLUDE_DIR half/half.hpp)@#find_path(HALF_INCLUDE_DIR half/half.hpp)@' CMakeLists.txt
# #include <half/half.hpp> -> <half.hpp>
for f in `find . -type f -name '*.hpp' -o -name '*.cpp' `; do
    sed -i -e 's@#include <half/half.hpp>@#include <half.hpp>@' $f
done
# On 6.4.0
# ../test/verify.hpp:198:56: error: no member named 'expr' in namespace 'half_float::detail'
#  198 |     if constexpr(std::is_same_v<T, half_float::detail::expr>)
# This is not our float, hack it out
sed -i -e 's@std::is_same_v<T, half_float::detail::expr>@0@' test/verify.hpp

# Our use of modules confuse install locations
# The db is not installed relative to the lib dir.
# Hardcode its location
sed -i -e 's@GetLibPath().parent_path() / "share/miopen/db"@"/usr/share/miopen/db"@' src/db_path.cpp.in

# Unsupported compiler flags
sed -i -e 's@opts.push_back("-fno-offload-uniform-block");@//opts.push_back("-fno-offload-uniform-block");@' src/comgr.cpp

# Paths to clang
sed -i -e 's@llvm/bin/clang@bin/clang@' src/hip/hip_build_utils.cpp

if [ -d build ]; then
    rm -rf build
fi
mkdir build
cd build
cmake -G Ninja -S .. \
       -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
       -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
       -DBUILD_FILE_REORG_BACKWARD_COMPATIBILITY=OFF \
       -DROCM_SYMLINK_LIBS=OFF \
       -DHIP_PLATFORM=amd \
       -DGPU_TARGETS=$gpu \
       -DBUILD_TESTING=ON \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DCMAKE_SKIP_RPATH=ON \
       -DBoost_USE_STATIC_LIBS=OFF \
       -DMIOPEN_PARALLEL_LINK_JOBS=1 \
       -DMIOPEN_BACKEND=HIP \
       -DMIOPEN_BUILD_DRIVER=OFF \
       -DMIOPEN_ENABLE_AI_IMMED_MODE_FALLBACK=OFF \
       -DMIOPEN_ENABLE_AI_KERNEL_TUNING=OFF \
       -DMIOPEN_TEST_ALL=ON \
       -DMIOPEN_USE_HIPBLASLT=OFF \
       -DMIOPEN_USE_MLIR=OFF \
       -DMIOPEN_USE_COMPOSABLEKERNEL=OFF 

if [ -f build.ninja ]; then
    ninja -v 2>&1 | tee build.log
    if [ ${PIPESTATUS[0]} != 0 ]; then
	echo "Error in build"
    else
	ninja -v test/gtest/all 2>&1 | tee -a build.log
	if [ ${PIPESTATUS[0]} != 0 ]; then
	    echo "Error in test build"
	fi
    fi
fi

bash

