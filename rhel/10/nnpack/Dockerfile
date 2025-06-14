FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/nnpack.git
RUN dnf -y builddep nnpack/nnpack.spec
RUN spectool -g -R nnpack/nnpack.spec
RUN cp -r nnpack/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba nnpack/nnpack.spec

CMD ["bash"]