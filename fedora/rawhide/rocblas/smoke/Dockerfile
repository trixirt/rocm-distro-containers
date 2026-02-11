FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocblas-devel

RUN git clone https://src.fedoraproject.org/rpms/rocblas.git
WORKDIR ./rocblas

CMD ["bash", "test.sh"]
# CMD ["bash"]

