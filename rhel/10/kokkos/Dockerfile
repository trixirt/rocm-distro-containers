FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/kokkos.git
RUN dnf -y builddep kokkos/kokkos.spec
RUN spectool -g -R kokkos/kokkos.spec
RUN cp -r kokkos/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba kokkos/kokkos.spec

CMD ["bash"]