FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocwmma.git
RUN dnf -y builddep rocwmma/rocwmma.spec
RUN spectool -g -R rocwmma/rocwmma.spec
RUN cp -r rocwmma/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocwmma/rocwmma.spec

CMD ["bash"]