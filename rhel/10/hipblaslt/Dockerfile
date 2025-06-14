FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipblaslt.git
RUN dnf -y builddep hipblaslt/hipblaslt.spec
RUN spectool -g -R hipblaslt/hipblaslt.spec
RUN cp -r hipblaslt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipblaslt/hipblaslt.spec

CMD ["bash"]