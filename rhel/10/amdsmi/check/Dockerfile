FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/amdsmi.git
RUN dnf -y builddep amdsmi/amdsmi.spec
RUN spectool -g -R amdsmi/amdsmi.spec
RUN cp -r amdsmi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba amdsmi/amdsmi.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["amd-smi", "list"]
