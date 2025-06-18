FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipsolver.git
RUN dnf -y builddep hipsolver/hipsolver.spec
RUN spectool -g -R hipsolver/hipsolver.spec
RUN cp hipsolver/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 gtest-devel \
 hipsparse-devel \
 blas-static \
 lapack-static

RUN rpmbuild -ba --with test hipsolver/hipsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["hipsolver-test"]