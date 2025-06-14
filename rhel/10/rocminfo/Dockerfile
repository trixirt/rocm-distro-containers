FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocminfo.git
RUN dnf -y builddep rocminfo/rocminfo.spec
RUN spectool -g -R rocminfo/rocminfo.spec
RUN cp -r rocminfo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocminfo/rocminfo.spec

CMD ["bash"]