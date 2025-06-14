FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocthrust.git
RUN dnf -y builddep rocthrust/rocthrust.spec
RUN spectool -g -R rocthrust/rocthrust.spec
RUN cp -r rocthrust/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocthrust/rocthrust.spec

CMD ["bash"]