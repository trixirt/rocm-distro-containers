FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocrand.git
RUN dnf -y builddep rocrand/rocrand.spec
RUN spectool -g -R rocrand/rocrand.spec
RUN cp rocrand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocrand/rocrand.spec

CMD ["bash"]