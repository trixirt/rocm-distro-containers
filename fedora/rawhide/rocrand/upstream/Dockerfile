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

RUN dnf -y builddep rocrand
RUN git clone https://github.com/ROCm/rocm-libraries

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
