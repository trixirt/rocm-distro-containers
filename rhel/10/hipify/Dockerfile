FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipify.git
RUN dnf -y builddep hipify/hipify.spec
RUN spectool -g -R hipify/hipify.spec
RUN cp -r hipify/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipify/hipify.spec

CMD ["bash"]