FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time

RUN dnf -y builddep miopen
RUN git clone -b rocm-7.2.0 https://github.com/ROCm/rocm-libraries

WORKDIR /rocm-libraries/projects/miopen
RUN dnf install -y gmock-devel gtest-devel

COPY build.sh build.sh

CMD ["bash", "build.sh"]
