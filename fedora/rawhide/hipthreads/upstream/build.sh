#!/bin/sh
set -e
set -x

export HIP_PATH=$(hipconfig -p)
export ROCM_PATH=$(hipconfig -R)
export HIP_CLANG_PATH=$(hipconfig -l)
gpu=$(rocm_agent_enumerator | grep -v gfx000 -m1)
export HIP_VISIBLE_DEVICES=0

export PATH="/usr/lib64/rocm/llvm/bin:$PATH"
LLVM_BINDIR=/usr/lib64/rocm/llvm/bin

cd /rocm-libraries/projects/hipthreads

# The sparse-mat-mul example data is git-LFS and opt-in on clone (#15313),
# so the checkout has pointer files. The default spmm run reads
# test_general.mtx (plain text) + shallow_water1.mtx (LFS). matrices.tgz
# (977 MB) is only used by the commented-out extra matrices in main():
git lfs pull --include="projects/hipthreads/examples/sparse-mat-mul/data/shallow_water1.mtx"
# git lfs pull --include="projects/hipthreads/examples/sparse-mat-mul/data/matrices.tgz"

# Fedora shared-library patch (projects/hipthreads/fedora in the monorepo).
# Monorepo path form, applied with -p3 like the spec's %autosetup:
#
# Disable shared
# patch -p3 --fuzz=0 -f < /0001-hipthreads-cmake-honor-build-shared-libs.patch

# ---------------------------------------------------------------------------
# 1. Packaging path (mirrors fedora/hipthreads.spec cmake args):
#    shared library, RelWithDebInfo, soname follows the ROCm release.
#    If the upstream #10169 blocker is real (device function pointer +
#    cross-TU RDC not device-linking into a .so), the build dies here at
#    the hip-link step of libhipthreads.so.
# ---------------------------------------------------------------------------
rm -rf build-pkg
cmake -S . -B build-pkg \
  -G Ninja \
  -DGPU_TARGETS=$gpu \
  -DCMAKE_AR=$LLVM_BINDIR/llvm-ar \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_C_COMPILER=$LLVM_BINDIR/amdclang \
  -DCMAKE_CXX_COMPILER=$LLVM_BINDIR/amdclang++ \
  -DCMAKE_INSTALL_LIBDIR=lib64 \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_LINKER=$LLVM_BINDIR/ld.lld \
  -DCMAKE_RANLIB=$LLVM_BINDIR/llvm-ranlib \
  -DCMAKE_SKIP_INSTALL_RPATH=ON \
  -DCMAKE_SKIP_RPATH=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DHIPTHREADS_SOVERSION=10.2 \
  -DROCM_SYMLINK_LIBS=OFF

ninja -C build-pkg
cmake --install build-pkg

# ls -l /usr/lib64/libhipthreads.so*
# readelf -d /usr/lib64/libhipthreads.so | grep SONAME

# ---------------------------------------------------------------------------
# 2. Upstream test path: the test tree is only added upstream for Debug
#    builds (top-level CMakeLists), which builds the 4 test/*.cxx
#    executables against the static library (unpatched code path).
#    Note: the upstream gate is `if (CMAKE_BUILD_TYPE MATCHES Debug)` -
#    case-sensitive, so it must be "Debug", not "DEBUG".
# ---------------------------------------------------------------------------
rm -rf build-test
cmake -S . -B build-test \
  -G Ninja \
  -DGPU_TARGETS=$gpu \
  -DCMAKE_AR=$LLVM_BINDIR/llvm-ar \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_C_COMPILER=$LLVM_BINDIR/amdclang \
  -DCMAKE_CXX_COMPILER=$LLVM_BINDIR/amdclang++ \
  -DCMAKE_LINKER=$LLVM_BINDIR/ld.lld \
  -DCMAKE_RANLIB=$LLVM_BINDIR/llvm-ranlib

ninja -C build-test
for t in compile_test hip_thread_mutex_test hip_thread_condvar_test mutex_test; do
    ./build-test/bin/$t
done

# ---------------------------------------------------------------------------
# 3. Examples: standalone CMake projects that find_package(hipthreads)
#    the library installed in step 1, i.e. real consumers of the shared
#    library (consumer-side link verification).
#    llama3.c is skipped: it needs LLaMA model weights.
# ---------------------------------------------------------------------------
build_example() {
    dir=$1
    bin=$2
    cd /rocm-libraries/projects/hipthreads/examples/$dir
    rm -rf build
    cmake -S . -B build \
      -G Ninja \
      -DGPU_TARGETS=$gpu \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER=$LLVM_BINDIR/amdclang \
      -DCMAKE_CXX_COMPILER=$LLVM_BINDIR/amdclang++ \
      -DCMAKE_LINKER=$LLVM_BINDIR/ld.lld
    ninja -C build
    # the consumer must pull in the installed shared library
    # ldd build/bin/$bin | grep hipthreads
    ./build/bin/$bin
}

build_example saxpy/step3-simdize saxpy
build_example sparse-mat-mul/step3-hipthread-port spmm
build_example InOneWeekendRaytracer/step3-hipthread-dropin inOneWeekend

echo "hipthreads upstream container: ALL TESTS PASSED"

bash
