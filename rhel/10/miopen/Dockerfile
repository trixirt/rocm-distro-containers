FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/miopen.git
RUN dnf -y builddep miopen/miopen.spec
RUN spectool -g -R miopen/miopen.spec
RUN cp -r miopen/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba miopen/miopen.spec

CMD ["bash"]