FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/aqlprofile.git
RUN dnf -y builddep --with test aqlprofile/aqlprofile.spec
RUN spectool -g -R aqlprofile/aqlprofile.spec
RUN cp aqlprofile/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test aqlprofile/aqlprofile.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["/usr/share/hsa-amd-aqlprofile/run_tests.sh"]

