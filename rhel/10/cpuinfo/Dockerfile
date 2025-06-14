FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/cpuinfo.git
RUN dnf -y builddep cpuinfo/cpuinfo.spec
RUN spectool -g -R cpuinfo/cpuinfo.spec
RUN cp -r cpuinfo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba cpuinfo/cpuinfo.spec

CMD ["bash"]