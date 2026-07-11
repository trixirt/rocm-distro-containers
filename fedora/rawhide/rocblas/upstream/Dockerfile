FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time \
 amdsmi-devel \
 rocm-smi-devel \
 libomp-devel \
 gcc-gfortran \
 gtest-devel \
 blas-devel

RUN dnf -y builddep rocblas
RUN git clone https://github.com/ROCm/rocm-libraries

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
