FROM fedora:rawhide

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
 roctracer-devel

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 rocm-smi-debuginfo \
 glibc-debuginfo \
 rocm-hip-debuginfo \
 libstdc++-debuginfo \
 libgcc-debuginfo \
 rocm-runtime-debuginfo \
 numactl-libs-debuginfo \
 libgfortran-debuginfo \
 libdrm-debuginfo \
 elfutils-libelf-debuginfo \
 zlib-ng-compat-debuginfo \
 libzstd-debuginfo \
 rocm-comgr-debuginfo

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone https://src.fedoraproject.org/rpms/rocblas.git
RUN dnf -y builddep rocblas/rocblas.spec
RUN spectool -g -R rocblas/rocblas.spec
RUN cp -r rocblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocblas/rocblas.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/rocblas*

CMD ["rocblas-test"]

# CMD ["gdb", "rocblas-test"]

