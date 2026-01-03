FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocminfo.git
RUN dnf -y builddep rocminfo/rocminfo.spec
RUN spectool -g -R rocminfo/rocminfo.spec
RUN cp rocminfo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocminfo/rocminfo.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["/usr/bin/rocminfo"]