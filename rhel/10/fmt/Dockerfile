FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/fmt.git
RUN dnf -y builddep fmt/fmt.spec
RUN spectool -g -R fmt/fmt.spec
RUN cp -r fmt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba fmt/fmt.spec

CMD ["bash"]