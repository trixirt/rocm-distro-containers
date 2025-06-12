FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocsolver.git
RUN dnf -y builddep rocsolver/rocsolver.spec
RUN spectool -g -R rocsolver/rocsolver.spec
RUN cp rocsolver/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 gcc-gfortran \
 gtest-devel \
 blas-static \
 lapack-static

RUN rpmbuild -ba --with test rocsolver/rocsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocsolver-test"]