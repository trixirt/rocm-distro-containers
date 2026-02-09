FROM fedora:42

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 cmake \
 emacs \
 git \
 rpm-build \
 rpmlint

RUN dnf builddep python3-torch 

RUN dnf download --source \
 python3-torch

RUN rpm -ihv python-torch*.src.rpm
RUN cd ~/rpmbuild/SPECS
RUN rpmbuild -bi python-torch.spec


CMD ["bash"]