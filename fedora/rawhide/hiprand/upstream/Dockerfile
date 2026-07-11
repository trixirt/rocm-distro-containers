FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time

RUN dnf -y builddep hiprand
RUN git clone https://github.com/ROCm/rocm-libraries

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
