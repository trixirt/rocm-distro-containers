FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 python3-torch \
 python3-expecttest \
 python3-psutil \
 python3-triton \
 pytest \
 rpm-build \
 rocminfo

RUN dnf download --source \
 python3-torch

RUN rpm -ihv --nosignature python-torch*.src.rpm
RUN dnf -y builddep ~/rpmbuild/SPECS/python-torch.spec
RUN rpmbuild -bp ~/rpmbuild/SPECS/python-torch.spec

COPY test.sh test.sh


CMD ["bash", "test.sh" ]