FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rccl.git
RUN dnf -y builddep rccl/rccl.spec
RUN spectool -g -R rccl/rccl.spec
RUN cp -r rccl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rccl/rccl.spec

CMD ["bash"]