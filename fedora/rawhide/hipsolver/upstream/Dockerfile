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
 gtest-devel \
 time

RUN dnf install -y \
 hipsparse-devel

RUN dnf -y builddep hipsolver
# Sparse clone to reduce download size - only clone hipsolver project
# Uses --filter=blob:none to skip large binary blobs and --sparse for selective checkout
# This reduces the clone from ~500MB to ~50-100MB
RUN git clone --filter=blob:none --sparse https://github.com/ROCm/rocm-libraries
WORKDIR /rocm-libraries
# Sparse checkout - only need the hipsolver project
RUN git sparse-checkout init --cone
RUN git sparse-checkout set projects/hipsolver

COPY build.sh build.sh

CMD ["bash", "build.sh"]
