FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 gcc-gfortran \
 blas-static \
 lapack-static

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 glibc-debuginfo \
 rocblas-debuginfo \
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

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocsolver.git
RUN dnf -y builddep rocsolver/rocsolver.spec
RUN spectool -g -R rocsolver/rocsolver.spec
RUN cp rocsolver/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test rocsolver/rocsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/rocsolver*

CMD ["rocsolver-test"]

# CMD ["gdb", "rocsolver-test"]
# CMD ["bash"]