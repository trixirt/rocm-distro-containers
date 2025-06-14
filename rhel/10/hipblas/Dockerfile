FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf -y builddep hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp -r hipblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipblas/hipblas.spec

CMD ["bash"]