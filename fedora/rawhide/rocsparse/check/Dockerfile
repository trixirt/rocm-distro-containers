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
 gcc-gfortran

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 rocm-hip-debuginfo \
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

RUN git clone https://src.fedoraproject.org/rpms/rocsparse.git
RUN dnf -y builddep rocsparse/rocsparse.spec
RUN spectool -g -R rocsparse/rocsparse.spec
RUN cp rocsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocsparse/rocsparse.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/rocsparse*

CMD ["rocsparse-test"]

# CMD ["gdb", "rocsparse-test"]