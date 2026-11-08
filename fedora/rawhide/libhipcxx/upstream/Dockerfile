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
 gtest-devel

RUN git clone --filter=blob:none --sparse https://github.com/ROCm/rocm-libraries
WORKDIR /rocm-libraries
# Sparse checkout - only need the libhipcxx project (nested in hipccl/hipccl3)
RUN git sparse-checkout init --cone
RUN git sparse-checkout set projects/hipccl/hipccl3/libhipcxx

COPY build.sh build.sh

CMD ["bash", "build.sh"]
