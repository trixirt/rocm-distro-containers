#!/bin/sh

# set -e
set -x

export HIP_PATH=$(hipconfig -p)
export ROCM_PATH=$(hipconfig -R)
export HIP_CLANG_PATH=$(hipconfig -l)
gpu=$(rocm_agent_enumerator | grep -v gfx000 -m1)

# Fallback
if [ -z "$gpu" ]; then
    echo "no gpu for you, exiting..."
    exit 1
fi

export PATH="/usr/lib64/rocm/llvm/bin:$PATH"

# Check if sccache is installed and verify by adding it to CC/CXX
if command -v sccache >/dev/null 2>&1; then
    echo "sccache detected. Enabling compiler caching."
    export CC=sccache
    export CXX=sccache
    # sccache needs to know the LLVM version type for 'clang' to avoid cache misses
    export LLVM_COMPILER=clang
else
    echo "sccache not found. Building with native compilers."
fi

export HIPCC_COMPILE_FLAGS_APPEND="--offload-compress"
export LD_LIBRARY_PATH="/llama.cpp/build/bin"

# Fixed: Removed spaces around '=' and added proper line continuations '\'
CMAKE_CONFIG=".. \
             -G Ninja \
              -DCMAKE_SKIP_RPATH=ON \
              -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
              -DCMAKE_C_COMPILER_LAUNCHER=sccache \
              -DCMAKE_HIP_COMPILER_LAUNCHER=sccache \
              -DCMAKE_CXX_COMPILER=/usr/lib64/rocm/llvm/bin/clang++ \
              -DCMAKE_C_COMPILER=/usr/lib64/rocm/llvm/bin/clang \
              -DCMAKE_HIP_COMPILER=/usr/lib64/rocm/llvm/bin/amdclang++ \
              -DGGML_AVX=OFF \
              -DGGML_AVX2=OFF \
              -DGGML_AVX512=OFF \
              -DGGML_AVX512_VBMI=OFF \
              -DGGML_AVX512_VNNI=OFF \
              -DGGML_FMA=OFF \
              -DGGML_F16C=OFF \
              -DGGML_HIP=ON \
              -DGGML_VULKAN=OFF \
              -DAMDGPU_TARGETS=${gpu} \
              -DLLAMA_BUILD_EXAMPLES=ON \
              -DLLAMA_BUILD_TESTS=ON"


cd /llama.cpp
LAST_UPDATE_FILE="/tmp/llama_cpp_update_commit"
LAST_BUILD_FILE="/tmp/llama_cpp_build_commit"
LAST_FAIL_FILE="/tmp/llama_cpp_fail_commit"

# Configure loop behavior based on argument
ITERATION=1
MAX_ITER=-1  # -1 implies infinite

case "$1" in
    loop)
        MAX_ITER=1000
        ;;
    *[!0-9]*)
        # Non-numeric argument defaults to 1
        MAX_ITER=1
        ;;
    *)
        # Numeric argument or empty string
        if [ -n "$1" ]; then
            MAX_ITER=$1
        else
            MAX_ITER=1
        fi
        ;;
esac

# Counted Loop
while [ "$ITERATION" -le "$MAX_ITER" ]; do
    cd /llama.cpp
    git remote update
    
    REMOTE_COMMIT=$(git rev-parse @{u})
    
    if [ -f "$LAST_UPDATE_FILE" ]; then
        LAST_UPDATE_COMMIT=$(cat "$LAST_UPDATE_FILE")
    else
        LAST_UPDATE_COMMIT=""
    fi
    
    if [ "$REMOTE_COMMIT" != "$LAST_UPDATE_COMMIT" ]; then
        echo "Repo updated. Building..."
        git pull
        CURRENT_COMMIT=$(git rev-parse HEAD)
        
        # Check if the current commit is exactly on a tag
        CURRENT_TAG=$(git describe --exact-match --tags 2>/dev/null || true)
        
        if [ -n "$CURRENT_TAG" ]; then
            echo "Tagged release: $CURRENT_TAG ($CURRENT_COMMIT)"
        else
            echo "Build Commit: $CURRENT_COMMIT"
        fi
    
        if [ -d /llama.cpp/build ]; then
            rm -rf /llama.cpp/build
        fi
        
        mkdir -p build
        cd build
        
        cmake ${CMAKE_CONFIG}
        
        if [ -f build.ninja ]; then
            ninja
	    if [ $? = 0 ]; then
		echo $CURRENT_COMMIT > "$LAST_BUILD_FILE"
		
		# Use tag in the output filename if defined
		BASE_NAME="test_results"
		if [ -n "$CURRENT_TAG" ]; then
		    BASE_NAME="${BASE_NAME}_${CURRENT_TAG}"
		else
		    BASE_NAME="${BASE_NAME}_$(echo $CURRENT_COMMIT | cut -c1-8)"
		fi
		ctest --output-on-failure --output-junit "${BASE_NAME}.xml"
		
		# Print ccache stats on success
		echo "\n=== sccache stats ==="
		sccache --show-stats || echo "sccache stats unavailable"
		echo "====================="
	    else
		echo $CURRENT_COMMIT > "$LAST_FAIL_FILE"
	    fi
            
        else
            echo "failed to build"
	    echo $CURRENT_COMMIT > "$LAST_FAIL_FILE"
        fi
    
        # Update the "last seen update" to the current commit
	echo $CURRENT_COMMIT > "$LAST_UPDATE_FILE"
	
        sleep 60
    else
        sleep 600
    fi
    
    ITERATION=$((ITERATION + 1))
done