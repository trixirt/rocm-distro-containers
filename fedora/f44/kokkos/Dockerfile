FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/kokkos.git
RUN dnf -y builddep kokkos/kokkos.spec
RUN spectool -g -R kokkos/kokkos.spec
RUN cp kokkos/* ~/rpmbuild/SOURCES
#
# Module do not run well in containers, do this by hand
# RUN rpmbuild -ba --with rocm_test kokkos/kokkos.spec
# expects to be run on gfx1100

CMD ["bash"]