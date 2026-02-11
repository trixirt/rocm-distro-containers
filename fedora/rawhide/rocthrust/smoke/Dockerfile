FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocprim-devel \
 rocthrust-devel

RUN git clone https://src.fedoraproject.org/rpms/rocthrust.git
WORKDIR ./rocthrust

CMD ["bash", "test.sh"]
# CMD ["bash"]

