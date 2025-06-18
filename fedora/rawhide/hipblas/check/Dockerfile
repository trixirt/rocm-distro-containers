FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf -y builddep hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp hipblas/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 blas-static \
 lapack-static \
 python3-pyyaml \
 gtest-devel

RUN rpmbuild -ba --with test hipblas/hipblas.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

# CMD ["hipblas-test"]

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 rocm-hip-debuginfo \
 gtest-debuginfo \
 libgfortran-debuginfo \
 libstdc++-debuginfo \
 glibc-debuginfo \
 libgcc-debuginfo \
 rocblas-debuginfo \
 rocm-runtime-debuginfo \
 numactl-libs-debuginfo \
 libdrm-debuginfo \
 elfutils-libelf-debuginfo \
 zlib-ng-compat-debuginfo \
 libzstd-debuginfo \
 rocm-comgr-debuginfo

CMD ["gdb", "hipblas-test"]
