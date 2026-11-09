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
 time

RUN dnf install -y \
 gtest-devel \
 composable_kernel-devel \
 libzstd-devel

RUN dnf -y builddep hipsolver

RUN git clone --filter=blob:none --sparse https://github.com/ROCm/rocm-libraries
WORKDIR /rocm-libraries
# Sparse checkout - need hiptensor
RUN git sparse-checkout init --cone
RUN git sparse-checkout set projects/hiptensor

COPY build.sh build.sh

CMD ["bash", "build.sh"]
