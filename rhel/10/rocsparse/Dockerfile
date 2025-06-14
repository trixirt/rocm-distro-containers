FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocsparse.git
RUN dnf -y builddep rocsparse/rocsparse.spec
RUN spectool -g -R rocsparse/rocsparse.spec
RUN cp -r rocsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocsparse/rocsparse.spec

CMD ["bash"]