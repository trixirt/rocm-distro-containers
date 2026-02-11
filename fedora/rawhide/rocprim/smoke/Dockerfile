FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocprim-devel

RUN git clone https://src.fedoraproject.org/rpms/rocprim.git
WORKDIR ./rocprim

CMD ["bash", "test.sh"]
# CMD ["bash"]

