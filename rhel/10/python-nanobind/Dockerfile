FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/python-nanobind.git
RUN dnf -y builddep python-nanobind/python-nanobind.spec
RUN spectool -g -R python-nanobind/python-nanobind.spec
RUN cp -r python-nanobind/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-nanobind/python-nanobind.spec

CMD ["bash"]