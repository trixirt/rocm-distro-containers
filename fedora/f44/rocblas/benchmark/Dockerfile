FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 blas-devel \
 libomp-devel \
 python3-pyyaml \
 rocminfo \
 rocm-smi-devel \
 roctracer-devel \
 gtest-devel

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocblas.git
RUN dnf -y builddep rocblas/rocblas.spec
RUN spectool -g -R rocblas/rocblas.spec
RUN cp -r rocblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocblas/rocblas.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rocblas-bench", "-f", "gemv", "-r", "s", "-m", "10240", "-n", "10240", "--lda", "10240"]


