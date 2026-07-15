FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocm-bandwidth-test.git
RUN dnf -y builddep rocm-bandwidth-test/rocm-bandwidth-test.spec
RUN spectool -g -R rocm-bandwidth-test/rocm-bandwidth-test.spec
RUN cp -r rocm-bandwidth-test/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-bandwidth-test/rocm-bandwidth-test.spec

CMD ["bash"]