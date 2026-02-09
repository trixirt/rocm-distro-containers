FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocrand.git
RUN dnf -y builddep rocrand/rocrand.spec
RUN spectool -g -R rocrand/rocrand.spec
RUN cp rocrand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocrand/rocrand.spec

CMD ["bash"]