FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocrand-devel

RUN git clone https://src.fedoraproject.org/rpms/rocrand.git
WORKDIR ./rocrand

CMD ["bash", "test.sh"]
# CMD ["bash"]

