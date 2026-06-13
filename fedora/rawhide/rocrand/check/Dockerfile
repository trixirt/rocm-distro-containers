FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo

RUN git clone https://src.fedoraproject.org/rpms/rocrand.git
RUN dnf -y builddep --with test rocrand/rocrand.spec
RUN spectool -g -R rocrand/rocrand.spec
RUN cp -r rocrand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocrand/rocrand.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/rocrand*

COPY test.sh /

CMD ["/test.sh"]
