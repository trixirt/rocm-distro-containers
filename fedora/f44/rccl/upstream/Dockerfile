FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time

RUN dnf -y builddep rccl
# RUN git clone -b rocm-7.1.1 https://github.com/ROCm/rocm-systems
RUN git clone -b rocm-7.1.1 https://github.com/ROCm/rccl

COPY build.sh build.sh

CMD ["bash", "build.sh"]
