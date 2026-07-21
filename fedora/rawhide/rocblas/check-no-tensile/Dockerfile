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

RUN git clone https://src.fedoraproject.org/rpms/rocblas.git
RUN dnf -y builddep --with test rocblas/rocblas.spec
RUN spectool -g -R rocblas/rocblas.spec
RUN cp -r rocblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test --without tensile rocblas/rocblas.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/rocblas*

COPY test.sh /

CMD ["/test.sh"]

# CMD ["gdb", "rocblas-test"]

