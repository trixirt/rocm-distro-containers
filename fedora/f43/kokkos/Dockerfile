FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/kokkos.git
RUN dnf -y builddep kokkos/kokkos.spec
RUN spectool -g -R kokkos/kokkos.spec
RUN cp kokkos/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba kokkos/kokkos.spec

CMD ["bash"]