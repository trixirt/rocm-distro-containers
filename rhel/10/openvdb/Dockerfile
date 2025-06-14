FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/openvdb.git
RUN dnf -y builddep openvdb/openvdb.spec
RUN spectool -g -R openvdb/openvdb.spec
RUN cp -r openvdb/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba openvdb/openvdb.spec

CMD ["bash"]