FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocprim-devel \
 rocthrust-devel

RUN git clone https://gitlab.archlinux.org/archlinux/packaging/packages/rocthrust.git
WORKDIR ./rocthrust

# CMD ["bash", "test.sh"]
CMD ["bash"]

