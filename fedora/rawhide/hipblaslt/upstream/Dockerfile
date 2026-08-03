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
 blas-devel \
 roctracer-devel \
 blis-devel \
 lapack-devel

RUN dnf -y builddep hipblaslt
RUN git clone --sparse --filter=blob:none https://github.com/ROCm/rocm-libraries
RUN cd rocm-libraries; git sparse-checkout set cmake shared projects/hipblaslt

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
