FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-torchvision.git
RUN dnf -y builddep python-torchvision/python-torchvision.spec
RUN spectool -g -R python-torchvision/python-torchvision.spec
RUN cp python-torchvision/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-torchvision/python-torchvision.spec

CMD ["bash"]