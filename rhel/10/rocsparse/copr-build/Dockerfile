FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

# EPEL10 copr, where in-development build it
RUN dnf config-manager --setopt=repo_id.gpgcheck=0 --add-repo https://download.copr.fedorainfracloud.org/results/@rocm-packagers-sig/EPEL10/epel-10-x86_64/

RUN dnf update --nogpgcheck -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/rocsparse.git
RUN dnf --nogpgcheck -y builddep rocsparse/rocsparse.spec
RUN spectool -g -R rocsparse/rocsparse.spec
RUN cp -r rocsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocsparse/rocsparse.spec

# Now try to build --with test
RUN dnf --nogpgcheck install -y gtest-devel libomp-devel rocblas-devel gcc-fortran python3-pyyaml
RUN rpmbuild --with test -ba rocsparse/rocsparse.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN dnf --nogpgcheck --enablerepo='*debug*' install -y \
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

CMD ["gdb", "rocsparse-test"]
# CMD ["bash"]