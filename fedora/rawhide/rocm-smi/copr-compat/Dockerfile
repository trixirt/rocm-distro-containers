FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

# compat copr
RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/compat/repo/fedora-rawhide/group_rocm-packagers-sig-compat-fedora-rawhide.repo

RUN dnf update --nogpgcheck -y

RUN git clone https://src.fedoraproject.org/rpms/rocm-smi.git
RUN dnf --nogpgcheck -y builddep --with compat --with test rocm-smi/rocm-smi.spec
RUN spectool -g -R rocm-smi/rocm-smi.spec
RUN cp rocm-smi/* ~/rpmbuild/SOURCES

# RUN rpmbuild -ba --with compat --with test rocm-smi/rocm-smi.spec

# RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash"]

