FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocm-cmake.git
RUN dnf -y builddep rocm-cmake/rocm-cmake.spec
RUN spectool -g -R rocm-cmake/rocm-cmake.spec
RUN cp -r rocm-cmake/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-cmake/rocm-cmake.spec

CMD ["bash"]