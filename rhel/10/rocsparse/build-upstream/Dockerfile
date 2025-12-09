FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN dnf install -y \
 libomp-devel \
 python3-pyyaml \
 rocblas-devel \
 gcc-gfortran \
 gtest-devel

RUN dnf download --source rocsparse
RUN rpm -ihv *.rpm
RUN dnf -y builddep ~/rpmbuild/SPECS/*.spec
RUN rpmbuild -ba --with test ~/rpmbuild/SPECS/*.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

# CMD ["rocsparse-test"]

RUN dnf --enablerepo='*debug*' install -y \
 gdb \
 gtest-debuginfo \
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

#CMD ["gdb", "rocsparse-test"]

ENV CC=/usr/bin/hipcc
ENV CXX=/usr/bin/hipcc
ENV FFLAGS="-fPIC"
ENV FCFLAGS="-fPIC"

WORKDIR /app
RUN git clone --no-checkout --filter=blob:none https://github.com/ROCm/rocm-libraries.git && \
    cd rocm-libraries && \
    git sparse-checkout init --cone && \
    git sparse-checkout set projects/rocsparse projects/hipsparse projects/rocprim projects/rocrand projects/rocblas && \
    git checkout develop

RUN cd /app/rocm-libraries/projects/rocprim && \
    ./install -i

RUN cd /app/rocm-libraries/projects/rocsparse && \
    ./install.sh -c --no-rocblas