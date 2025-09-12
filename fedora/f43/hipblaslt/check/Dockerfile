FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblaslt.git
RUN dnf -y builddep hipblaslt/hipblaslt.spec
RUN spectool -g -R hipblaslt/hipblaslt.spec
RUN cp hipblaslt/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 hipcc-libomp-devel \
 blas-static \
 gcc-gfortran \
 gmock-devel \
 gtest-devel

RUN rpmbuild -ba --with test hipblaslt/hipblaslt.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["hipblaslt-test"]
