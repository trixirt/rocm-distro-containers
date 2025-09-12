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

# Testing defaults to gfx1100, so do this on a machine with this gpu.
# CMD ["/usr/bin/bash", "-c", "rpmbuild -ba --with rocm_test kokkos/kokkos.spec" ]
CMD ["/usr/bin/bash"]