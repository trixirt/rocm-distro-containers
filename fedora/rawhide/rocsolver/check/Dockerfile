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

# CMD ["rocsolver-test"]

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 glibc-debuginfo \
 rocblas-debuginfo \
 gtest-debuginfo \
 fmt-debuginfo \
 rocm-hip-debuginfo \
 libgfortran-debuginfo \
 libstdc++-debuginfo \
 libgcc-debuginfo \
 rocm-runtime-debuginfo \
 numactl-libs-debuginfo \
 libdrm-debuginfo \
 elfutils-libelf-debuginfo \
 zlib-ng-compat-debuginfo \
 libzstd-debuginfo \
 rocm-comgr-debuginfo

CMD ["gdb", "rocsolver-test"]