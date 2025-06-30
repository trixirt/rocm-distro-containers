FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf install -y \
 gtest-devel

RUN dnf update -y

RUN dnf download --source rocrand
RUN rpm -ihv rocrand*.rpm
RUN dnf -y builddep ~/rpmbuild/SPECS/rocrand.spec
RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/rocrand.spec

# RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocrand.git
# RUN dnf --nogpgcheck -y builddep --with test rocrand/rocrand.spec
# RUN spectool -g -R rocrand/rocrand.spec
# RUN cp -r rocrand/* ~/rpmbuild/SOURCES
# RUN rpmbuild -ba --with test rocrand/rocrand.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash", "-c", "for f in /usr/bin/test_rocrand*; do $f; done"]
