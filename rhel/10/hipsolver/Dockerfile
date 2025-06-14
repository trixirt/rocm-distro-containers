FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/hipsolver.git
RUN dnf -y builddep hipsolver/hipsolver.spec
RUN spectool -g -R hipsolver/hipsolver.spec
RUN cp -r hipsolver/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipsolver/hipsolver.spec

CMD ["bash"]