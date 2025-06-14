FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/mivisionx.git
RUN dnf -y builddep mivisionx/mivisionx.spec
RUN spectool -g -R mivisionx/mivisionx.spec
RUN cp -r mivisionx/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba mivisionx/mivisionx.spec

CMD ["bash"]