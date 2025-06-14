FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocblas.git
RUN dnf -y builddep rocblas/rocblas.spec
RUN spectool -g -R rocblas/rocblas.spec
RUN cp -r rocblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocblas/rocblas.spec

CMD ["bash"]