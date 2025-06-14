FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocm-rpp.git
RUN dnf -y builddep rocm-rpp/rocm-rpp.spec
RUN spectool -g -R rocm-rpp/rocm-rpp.spec
RUN cp -r rocm-rpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-rpp/rocm-rpp.spec

CMD ["bash"]