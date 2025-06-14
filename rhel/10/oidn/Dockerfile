FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/oidn.git
RUN dnf -y builddep oidn/oidn.spec
RUN spectool -g -R oidn/oidn.spec
RUN cp -r oidn/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba oidn/oidn.spec

CMD ["bash"]