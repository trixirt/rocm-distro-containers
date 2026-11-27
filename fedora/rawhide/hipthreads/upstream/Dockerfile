FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 git-core \
 git-lfs \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time \
 cmake \
 gcc-c++

# Not in fedora yet so need to do the builddep manually
RUN dnf -y install libhipcxx-devel rocm-cmake rocm-hip-devel

# For examples/tests
RUN dnf install -y rocprim-devel rocthrust-devel

RUN git clone --filter=blob:none --sparse https://github.com/ROCm/rocm-libraries
WORKDIR /rocm-libraries
# Sparse checkout - only need the hipthreads project
RUN git sparse-checkout init --cone
RUN git sparse-checkout set projects/hipthreads

COPY build.sh build.sh
COPY 0001-hipthreads-cmake-honor-build-shared-libs.patch /0001-hipthreads-cmake-honor-build-shared-libs.patch

CMD ["bash", "build.sh"]
