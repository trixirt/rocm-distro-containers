FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipfort.git
RUN dnf -y builddep hipfort/hipfort.spec
RUN spectool -g -R hipfort/hipfort.spec
RUN cp -r hipfort/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipfort/hipfort.spec

CMD ["bash"]