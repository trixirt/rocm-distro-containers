FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocsparse-devel

RUN git clone https://src.fedoraproject.org/rpms/rocsparse.git
WORKDIR ./rocsparse

CMD ["bash", "test.sh"]
# CMD ["bash"]

