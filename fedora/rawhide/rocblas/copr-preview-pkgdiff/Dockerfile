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