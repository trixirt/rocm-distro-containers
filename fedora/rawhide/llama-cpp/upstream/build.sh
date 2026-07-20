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

export PATH="/usr/lib64/rocm/llvm/bin:$PATH"
export HIPCC_COMPILE_FLAGS_APPEND="--offload-compress"
export LD_LIBRARY_PATH="/llama.cpp/build/bin"

G="$gpu $gpu_generic"
G=$gpu
for g in $G; do
    cd /llama.cpp
    if [ -d build ]; then
	rm -rf build
    fi
    mkdir -p build
    prefix=$PWD/build/install
    cd build

    cmake .. \
	  -G Ninja \
	  -DCMAKE_SKIP_RPATH=ON \
	  -DGGML_AVX=OFF \
	  -DGGML_AVX2=OFF \
	  -DGGML_AVX512=OFF \
	  -DGGML_AVX512_VBMI=OFF \
	  -DGGML_AVX512_VNNI=OFF \
	  -DGGML_FMA=OFF \
	  -DGGML_F16C=OFF \
	  -DGGML_HIP=ON \
	  -DGGML_VULKAN=OFF \
	  -DAMDGPU_TARGETS=$gpu \
	  -DLLAMA_BUILD_EXAMPLES=ON \
	  -DLLAMA_BUILD_TESTS=ON
    
    if [ -f build.ninja ]; then
	ninja
	ctest --output-on-failure
#	bash
    else
	echo "failed to build"
	exit 1
    fi
done


