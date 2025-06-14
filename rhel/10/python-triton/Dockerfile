FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/python-triton.git
RUN dnf -y builddep python-triton/python-triton.spec
RUN spectool -g -R python-triton/python-triton.spec
RUN cp -r python-triton/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-triton/python-triton.spec

CMD ["bash"]