FROM ubuntu:25.04

RUN sed -i -e 's@Types: deb@Types: deb deb-src@' /etc/apt/sources.list.d/ubuntu.sources
# Installing git-buildpackage will fail without this
RUN echo "MIRRORSITE=http://archive.ubuntu.com/ubuntu" > /etc/pbuilderrc

RUN apt update
RUN apt install -y build-essential devscripts git git-buildpackage sbuild

RUN gbp clone --pristine-tar --upstream-branch experimental-llvmfork-package https://salsa.debian.org/tflink/rocm-llvm

RUN apt install -y \
 cmake \
 ninja-build \
 chrpath \
 texinfo \
 sharutils \
 libelf-dev \
 libffi-dev \
 libedit-dev \
 libncurses-dev \
 binutils-dev \
 libxml2-dev \
 libjsoncpp-dev \
 pkg-config \
 lcov \
 help2man \
 zlib1g-dev \
 libzstd-dev \
 dh-exec

CMD ["bash"]