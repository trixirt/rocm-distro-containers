FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocblas-devel \
 rocsolver-devel

RUN git clone https://src.fedoraproject.org/rpms/rocsolver.git
WORKDIR ./rocsolver

CMD ["bash", "test.sh"]
# CMD ["bash"]

