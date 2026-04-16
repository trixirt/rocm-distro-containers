# Dockerfile for ROCm ABI package diff testing
# This container sets up an environment to compare ABI compatibility between
# package versions from Fedora repository and ROCm COPR preview repository.
# It:
# 1. Installs required tools (cpio, libabigail, rpmlint, rpminspect)
# 2. Downloads old packages from Fedora repository to /a/ directory
# 3. Configures COPR preview repository and downloads new packages to /b/ directory
# 4. Runs test.sh script which performs ABI compatibility checks using abipkgdiff
#    and package analysis using rpmlint and rpminspect
# The test.log file contains the diff results

FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y cpio libabigail rpmlint rpminspect rpminspect-data-fedora

RUN mkdir /a
RUN dnf download -y rocfft --destdir=/a
RUN dnf download --source -y rocfft --destdir=/a
RUN dnf download -y rocfft-devel --destdir=/a
RUN dnf --enablerepo='*debug*' download -y rocfft-debuginfo --destdir=/a

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/preview/repo/fedora-rawhide/group_rocm-packagers-sig-preview-fedora-rawhide.repo
RUN dnf update --nogpgcheck -y

RUN mkdir /b
RUN dnf download -y rocfft --destdir=/b
RUN dnf download --source -y rocfft --destdir=/b
RUN dnf download -y rocfft-devel --destdir=/b
RUN dnf --enablerepo='*debug*' download -y rocfft-debuginfo --destdir=/b

COPY test.sh test.sh

# CMD ["bash"]
CMD ["./test.sh"]