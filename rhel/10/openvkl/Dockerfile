FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/openvkl.git
RUN dnf -y builddep openvkl/openvkl.spec
RUN spectool -g -R openvkl/openvkl.spec
RUN cp -r openvkl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba openvkl/openvkl.spec

CMD ["bash"]