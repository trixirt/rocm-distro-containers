# Dockerfile for ROCm ABI package diff testing
# This container sets up an environment to compare ABI compatibility between
# package versions from Fedora repository and ROCm COPR preview repository.
# It:
# 1. Installs required tools (cpio, libabigail)
# 2. Downloads old packages from Fedora repository to /a/ directory
# 3. Configures COPR preview repository and downloads new packages to /b/
#    directory
# 4. Runs abipkgdiff test to compare ABIs between the two versions
# The test.log file contains the diff results

FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y cpio libabigail

RUN mkdir /a
RUN dnf download -y rocblas --destdir=/a
RUN dnf download -y rocblas-devel --destdir=/a
RUN dnf --enablerepo='*debug*' download -y rocblas-debuginfo --destdir=/a

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/preview/repo/fedora-rawhide/group_rocm-packagers-sig-preview-fedora-rawhide.repo
RUN dnf update --nogpgcheck -y

RUN mkdir /b
RUN dnf download -y rocblas --destdir=/b
RUN dnf download -y rocblas-devel --destdir=/b
RUN dnf --enablerepo='*debug*' download -y rocblas-debuginfo --destdir=/b

COPY test.sh test.sh

# CMD ["bash"]
CMD ["./test.sh"]