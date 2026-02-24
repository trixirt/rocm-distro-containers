FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocblas-devel \
 rocsolver-devel \
 hipblas-devel

RUN git clone https://src.fedoraproject.org/rpms/hipblas.git
WORKDIR /hipblas

CMD ["bash", "test.sh"]
# CMD ["bash"]

