FROM opensuse/tumbleweed

RUN useradd -m -s /bin/bash trix
RUN zypper -n install \
 git \
 rpmbuild \
 rpmdevtools \
 rpmlint \
 sudo

# For package building
RUN zypper -n install \
 binutils-devel \
 cmake \
 fdupes \
 gcc-c++ \
 libffi-devel \
 libzstd-devel \
 zlib-devel

RUN rpmdev-setuptree
 

CMD ["bash"]