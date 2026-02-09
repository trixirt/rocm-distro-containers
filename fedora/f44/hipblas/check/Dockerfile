FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf -y builddep hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp hipblas/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 blas-static \
 lapack-static \
 python3-pyyaml

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 rocm-hip-debuginfo \
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

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN rpmbuild -ba --with test hipblas/hipblas.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/hipblas*

# CMD ["hipblas-test"]

CMD ["gdb", "hipblas-test"]
