FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocm-devel \
 time

RUN git clone https://github.com/ROCm/rocm-libraries

CMD ["bash"]
