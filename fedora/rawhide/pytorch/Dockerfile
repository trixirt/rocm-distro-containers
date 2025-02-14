FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 cmake \
 emacs \
 git \
 rpm-build \
 rpmlint

RUN dnf install -y \
 python3-torch \
 python3-expecttest \
 python3-psutil \
 pytest \
 rocminfo

RUN dnf download --source \
 python3-torch

RUN rpm -ihv python-torch*.src.rpm


CMD ["bash"]