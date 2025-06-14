FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hiprt.git
RUN dnf -y builddep hiprt/hiprt.spec
RUN spectool -g -R hiprt/hiprt.spec
RUN cp -r hiprt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hiprt/hiprt.spec

CMD ["bash"]