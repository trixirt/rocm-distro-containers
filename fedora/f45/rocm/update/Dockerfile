FROM fedora:45

# 1. Update base and install Rawhide repo definitions/GPG keys:
#   dnf upgrade --refresh -y         : Refresh metadata and bring all existing packages up to date first
#   dnf install -y fedora-repos-rawhide : Install Rawhide repository config files and GPG signing keys
RUN dnf upgrade --refresh -y
RUN dnf install -y fedora-repos-rawhide

RUN dnf install -y \
 rocm \
 rocm-devel \
 rocm-test

#   --releasever=rawhide   : Override the $releasever variable to point DNF to Rawhide repos
#   --setopt=deltarpm=false: Disable delta RPMs to avoid unnecessary CPU overhead during container builds
#   distro-sync            : Upgrade, downgrade, or synchronize installed packages to match Rawhide versions
#   --refresh              : Force DNF to download fresh repository metadata before resolving dependencies
RUN dnf --releasever=rawhide --setopt=deltarpm=false distro-sync --refresh -y

RUN cat /etc/fedora-release
RUN dnf check

CMD ["bash"]



