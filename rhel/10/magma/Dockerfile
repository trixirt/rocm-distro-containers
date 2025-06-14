FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/magma.git
RUN dnf -y builddep magma/magma.spec
RUN spectool -g -R magma/magma.spec
RUN cp -r magma/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba magma/magma.spec

CMD ["bash"]