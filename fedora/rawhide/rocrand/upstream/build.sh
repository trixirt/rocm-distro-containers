#!/bin/sh

set -e
set -x

gfx_generic() {
  local model_number="$1"
  case "$model_number" in
      gfx101*)
	  echo "gfx10-1-generic"
	  return 0
	  ;;
      gfx103*)
	  echo "gfx10-3-generic"
	  return 0
	  ;;
      gfx11*)
	  echo "gfx11-generic"
	  return 0
	  ;;
      gfx12*)
	  echo "gfx12-generic"
	  return 0
	  ;;
    *)
      echo "Unknown gfx model number: $model_number" >&2
      return 1
      ;;
  esac
}

export HIP_PATH=`hipconfig -p`
export ROCM_PATH=`hipconfig -R`
export HIP_CLANG_PATH=`hipconfig -l`
gpu=`rocm_agent_enumerator | grep -v gfx000 -m1`
gpu_generic=$(gfx_generic $gpu)

G="$gpu $gpu_generic"
for g in $G; do
    cd /rocm-libraries/projects/rocrand
    if [ -d build ]; then
	rm -rf build
    fi
    mkdir -p build
    prefix=$PWD/build/install
    cd build

    cmake .. \
	  -G Ninja \
	  -DAMDGPU_TARGETS=$g \
	  -DBUILD_TEST=ON \
	  -DCMAKE_AR=/usr/lib64/rocm/llvm/bin/llvm-ar \
	  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
	  -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
	  -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
	  -DCMAKE_INSTALL_PREFIX=$prefix \
	  -DCMAKE_LINKER=/usr/lib64/rocm/llvm/bin/ld.lld \
	  -DCMAKE_RANLIB=/usr/lib64/rocm/llvm/bin/llvm-ranlib
    
    if [ -f build.ninja ]; then
	ninja
	if [ $? = 0 ]; then
	    ninja install
	    export LD_LIBRARY_PATH=$prefix/lib64
	    $prefix/bin/test_rocrand_xorwow_prng
	else
	    echo "failed to build"
	    exit 1
	fi
    fi
done


