FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/amdsmi.git
RUN dnf -y builddep --with test amdsmi/amdsmi.spec
RUN spectool -g -R amdsmi/amdsmi.spec
RUN cp amdsmi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test amdsmi/amdsmi.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["/usr/share/amdsmi/tests/amdsmitst"]