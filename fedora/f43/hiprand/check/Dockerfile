FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 gtest-devel

RUN git clone https://src.fedoraproject.org/rpms/hiprand.git
RUN dnf -y builddep hiprand/hiprand.spec
RUN spectool -g -R hiprand/hiprand.spec
RUN cp -r hiprand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test hiprand/hiprand.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash", "-c", "for f in /usr/bin/test_hiprand*; do $f; done"]
