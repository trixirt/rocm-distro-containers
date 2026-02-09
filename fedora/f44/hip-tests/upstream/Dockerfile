FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo

RUN dnf -y builddep hip-tests
RUN git clone -b f44 https://github.com/ROCm/rocm-systems

RUN dnf install -y ninja-build

COPY build.sh build.sh

CMD ["bash", "build.sh"]
