FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hiprand.git
RUN dnf -y builddep hiprand/hiprand.spec
RUN spectool -g -R hiprand/hiprand.spec
RUN cp -r hiprand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hiprand/hiprand.spec

CMD ["bash"]