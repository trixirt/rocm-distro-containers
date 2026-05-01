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
#G="$gpu"
for g in $G; do
    cd /magma

    # Insert our gpu into Makefile
    n=`echo -n $g | sed 's/gfx//'`
    sed -i -e "s/1032/$n/" Makefile
    
    echo "BACKEND = hip"                          > make.inc
    echo "FORT = false"                          >> make.inc
    echo "GPU_TARGET = $gpu"                     >> make.inc
    make generate
    
    if [ -d build ]; then
	rm -rf build
    fi
    mkdir -p build
    prefix=$PWD/build/install
    cd build

    cmake .. \
	  -G Ninja \
	  -DAMDGPU_TARGETS=$gpu \
	  -DBLA_VENDOR=FlexiBLAS \
	  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
	  -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
	  -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
	  -DCMAKE_INSTALL_PREFIX=$prefix \
	  -DMAGMA_ENABLE_HIP=ON \
	  -DUSE_FORTRAN=OFF
    
    if [ -f build.ninja ]; then
	ninja
	if [ $? = 0 ]; then
	    ninja install
	else
	    echo "failed to build"
	    exit 1
	fi
    fi
done


