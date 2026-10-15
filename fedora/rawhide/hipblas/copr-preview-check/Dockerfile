FROM fedora:rawhide

RUN dnf update -y
RUN dnf install -y retry

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/preview/repo/fedora-rawhide/group_rocm-packagers-sig-preview-fedora-rawhide.repo

RUN retry -d 1200 -j 60 -t 10 dnf install --nogpgcheck -y hipblas-test

CMD ["hipblas-test"]

