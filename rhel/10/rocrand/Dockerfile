FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocrand.git
RUN dnf -y builddep rocrand/rocrand.spec
RUN spectool -g -R rocrand/rocrand.spec
RUN cp -r rocrand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocrand/rocrand.spec

CMD ["bash"]