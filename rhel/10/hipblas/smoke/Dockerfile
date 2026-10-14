FROM quay.io/centos/centos:stream10

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocblas-devel \
 rocsolver-devel \
 hipblas-devel

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipblas.git
WORKDIR /hipblas

CMD ["bash", "test.sh"]
# CMD ["bash"]

