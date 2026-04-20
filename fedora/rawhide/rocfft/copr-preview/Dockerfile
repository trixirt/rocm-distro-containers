FROM fedora:rawhide

RUN dnf update -y

# preview copr
RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/preview/repo/fedora-rawhide/group_rocm-packagers-sig-preview-fedora-rawhide.repo

RUN dnf update --nogpgcheck -y
RUN dnf --nogpgcheck -y install rocfft-test

# CMD ["rocfft-test"]
CMD ["bash"]

