FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 cmake \
 emacs \
 git \
 rpm-build \
 rpmlint \
 sudo

rpmdev-setuptree

CMD ["bash"]