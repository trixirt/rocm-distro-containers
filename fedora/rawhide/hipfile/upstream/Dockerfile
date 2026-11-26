FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 git-core \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time \
 gtest-devel \
 cmake \
 gcc-c++ \
 libmount-devel \
 rocm-cmake \
 rocm-compilersupport-macros \
 rocm-hip-devel \
 rocm-rpm-macros \
 rocprofiler-register-devel \
 gtest-devel \
 gmock-devel \
 gdb


RUN git clone --filter=blob:none --sparse https://github.com/ROCm/rocm-systems
WORKDIR /rocm-systems
# Sparse checkout - only need the hipfile project
RUN git sparse-checkout init --cone
RUN git sparse-checkout set projects/hipfile

COPY build.sh build.sh

CMD ["bash", "build.sh"]
