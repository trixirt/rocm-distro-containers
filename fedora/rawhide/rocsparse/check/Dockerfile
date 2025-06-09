FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 libomp-devel \
 python3-pyyaml \
 rocblas-devel \
 gcc-gfortran \
 gtest-devel

RUN git clone https://src.fedoraproject.org/rpms/rocsparse.git
RUN dnf -y builddep rocsparse/rocsparse.spec
RUN spectool -g -R rocsparse/rocsparse.spec
RUN cp rocsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocsparse/rocsparse.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocsparse-test"]