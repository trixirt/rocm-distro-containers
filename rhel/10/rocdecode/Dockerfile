FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocdecode.git
RUN dnf -y builddep rocdecode/rocdecode.spec
RUN spectool -g -R rocdecode/rocdecode.spec
RUN cp -r rocdecode/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocdecode/rocdecode.spec

CMD ["bash"]