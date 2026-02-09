FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 python3-torchvision \
 python3-expecttest \
 python3-psutil \
 pytest \
 rpm-build \
 rocminfo

RUN dnf download --source \
 python3-torchvision

RUN rpm -ihv python-torchvision*.src.rpm
RUN dnf -y builddep ~/rpmbuild/SPECS/python-torchvision.spec
RUN rpmbuild -bp ~/rpmbuild/SPECS/python-torchvision.spec

COPY test.sh test.sh
CMD ["bash", "test.sh" ]

# CMD ["bash" ]