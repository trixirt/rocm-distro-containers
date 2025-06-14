FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocm-core.git
RUN dnf -y builddep rocm-core/rocm-core.spec
RUN spectool -g -R rocm-core/rocm-core.spec
RUN cp -r rocm-core/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-core/rocm-core.spec

CMD ["bash"]