FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocfft-devel

RUN git clone https://src.fedoraproject.org/rpms/rocfft.git
WORKDIR ./rocfft

CMD ["bash", "test.sh"]
# CMD ["bash"]

