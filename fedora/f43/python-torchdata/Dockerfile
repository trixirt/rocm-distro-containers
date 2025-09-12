FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-torchdata.git
RUN dnf -y builddep python-torchdata/python-torchdata.spec
RUN spectool -g -R python-torchdata/python-torchdata.spec
RUN cp python-torchdata/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-torchdata/python-torchdata.spec

CMD ["bash"]