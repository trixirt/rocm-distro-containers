FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/gloo.git
RUN dnf -y builddep gloo/gloo.spec
RUN spectool -g -R gloo/gloo.spec
RUN cp -r gloo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gloo/gloo.spec

CMD ["bash"]