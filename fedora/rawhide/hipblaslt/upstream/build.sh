#!/bin/sh

# set -e
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

gfx_valid() {
  local model_number="$1"
  case "$model_number" in
      gfx1100)
	  echo "gfx1100"
	  ;;
      gfx1101)
	  echo "gfx1101"
	  ;;
      gfx1102)
	  echo "gfx1102"
	  ;;
      gfx1103)
	  echo "gfx1103"
	  ;;
      gfx1150)
	  echo "gfx1150"
	  ;;
      gfx1151)
	  echo "gfx1151"
	  ;;
      gfx1152)
	  echo "gfx1152"
	  ;;
      gfx1153)
	  echo "gfx1153"
	  ;;
      gfx1200)
	  echo "gfx1200"
	  ;;
      gfx1201)
	  echo "gfx1201"
	  ;;
      *)
	  echo "gfx1100"
	  ;;
  esac
}

export HIP_PATH=`hipconfig -p`
export ROCM_PATH=`hipconfig -R`
export HIP_CLANG_PATH=`hipconfig -l`
gpu=`rocm_agent_enumerator | grep -v gfx000 -m1`
gpu_generic=$(gfx_generic $gpu)
gpu=$(gfx_valid $gpu)

export PATH="/usr/lib64/rocm/llvm/bin:$PATH"

G="$gpu $gpu_generic"
G=$gpu
for g in $G; do
    cd /rocm-libraries/projects/hipblaslt
    if [ -d build ]; then
	rm -rf build
    fi
    mkdir -p build
    prefix=$PWD/build/install
    cd build

    cmake .. \
	  -G Ninja \
	  -DGPU_TARGETS=$g \
	  -DCMAKE_AR=/usr/lib64/rocm/llvm/bin/llvm-ar \
	  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
	  -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
	  -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang \
	  -DCMAKE_INSTALL_PREFIX=$prefix \
	  -DCMAKE_LINKER=/usr/lib64/rocm/llvm/bin/ld.lld \
	  -DCMAKE_RANLIB=/usr/lib64/rocm/llvm/bin/llvm-ranlib \
	  -DHIPBLASLT_ENABLE_CLIENT=OFF \
	  -DHIPBLASLT_ENABLE_MARKER=OFF \
	  -DHIPBLASLT_ENABLE_OPENMP=OFF \
	  -DHIPBLASLT_ENABLE_ROCROLLER=OFF \
	  -DHIPBLASLT_ENABLE_SAMPLES=OFF
    
    if [ -f build.ninja ]; then
	ninja
	ctest --output-on-failure
    else
	echo "failed to build"
#	exit 1
    fi
    bash
done


