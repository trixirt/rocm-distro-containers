FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo

RUN dnf -y builddep hip-tests
RUN git clone https://github.com/ROCm/rocm-systems

RUN dnf install -y ninja-build

COPY build.sh build.sh

CMD ["bash", "build.sh"]
