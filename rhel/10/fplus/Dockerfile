FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/fplus.git
RUN dnf -y builddep fplus/fplus.spec
RUN spectool -g -R fplus/fplus.spec
RUN cp -r fplus/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba fplus/fplus.spec

CMD ["bash"]