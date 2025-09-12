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

RUN git clone https://src.fedoraproject.org/rpms/rocrand.git
RUN dnf -y builddep rocrand/rocrand.spec
RUN spectool -g -R rocrand/rocrand.spec
RUN cp -r rocrand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocrand/rocrand.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash", "-c", "for f in /usr/bin/test_rocrand*; do $f; done"]