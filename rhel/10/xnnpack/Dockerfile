FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/xnnpack.git
RUN dnf -y builddep xnnpack/xnnpack.spec
RUN spectool -g -R xnnpack/xnnpack.spec
RUN cp -r xnnpack/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba xnnpack/xnnpack.spec

CMD ["bash"]