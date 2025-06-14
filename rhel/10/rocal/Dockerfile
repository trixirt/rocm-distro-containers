FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocal.git
RUN dnf -y builddep rocal/rocal.spec
RUN spectool -g -R rocal/rocal.spec
RUN cp -r rocal/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocal/rocal.spec

CMD ["bash"]