FROM fedora:f44

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

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hipfft.git
RUN dnf --nogpgcheck -y builddep --with compat --with test hipfft/hipfft.spec
RUN spectool -g -R hipfft/hipfft.spec
RUN cp hipfft/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with compat --with test hipfft/hipfft.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash"]

