FROM fedora:rawhide

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/compat/repo/fedora-rawhide/group_rocm-packagers-sig-compat-fedora-rawhide.repo
RUN dnf update --nogpgcheck -y

RUN dnf install -y rocm-smi7.2 btop

CMD ["bash"]

