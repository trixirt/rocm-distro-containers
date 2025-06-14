FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocclr.git
RUN dnf -y builddep rocclr/rocclr.spec
RUN spectool -g -R rocclr/rocclr.spec
RUN cp -r rocclr/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocclr/rocclr.spec

CMD ["bash"]