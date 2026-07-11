FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/rocm-test/repo/fedora-rawhide/group_rocm-packagers-sig-rocm-test-fedora-rawhide.repo

RUN dnf install --nogpgcheck -y rocblas-test

CMD ["/usr/bin/rocblas-test"]