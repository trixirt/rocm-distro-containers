FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 ninja-build \
 rpm-build \
 rpmdevtools

RUN dnf -y builddep magma
RUN git clone -b v2.10.0 https://github.com/icl-utk-edu/magma

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
