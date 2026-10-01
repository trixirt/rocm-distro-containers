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
RUN dnf install -y cpio libabigail rpmlint rpminspect rpminspect-data-fedora  abi-compliance-checker

RUN mkdir /b
RUN dnf download -y rocm-hip --destdir=/b
RUN dnf download --source -y rocclr --destdir=/b
RUN dnf download -y rocm-hip-devel --destdir=/b
RUN dnf --enablerepo='*debug*' download -y rocm-hip-debuginfo --destdir=/b

RUN dnf copr -y enable @rocm-packagers-sig/F44
RUN dnf update --nogpgcheck -y

RUN mkdir /a
RUN dnf --disablerepo="*" --enablerepo="*F44" download -y rocm-hip --destdir=/a
#RUN dnf --disablerepo="*" --enablerepo="*F44" --source -y rocclr --destdir=/a
RUN dnf --disablerepo="*" --enablerepo="*F44" download -y rocm-hip-devel --destdir=/a
RUN dnf --disablerepo="*" --enablerepo="*F44" download -y rocm-hip-debuginfo --destdir=/a

COPY test.sh test.sh

# CMD ["bash"]
CMD ["./test.sh"]