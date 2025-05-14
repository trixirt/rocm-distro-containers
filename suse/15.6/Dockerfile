FROM registry.suse.com/bci/bci-base:15.6

RUN useradd -m -s /bin/bash trix

RUN zypper -n install \
 emacs \
 git \
 rpm-build \
 rpmlint \
 sudo

# For package building
RUN zypper -n install \
 binutils-devel \
 cmake \
 fdupes \
 gcc-c++ \
 libdrm-devel \
 libelf-devel \
 libffi-devel \
 libnuma-devel \
 libzstd-devel \
 Mesa-libGL-devel \
 zlib-devel

RUN mkdir -p /usr/src/packages/SOURCES 

CMD ["bash"]