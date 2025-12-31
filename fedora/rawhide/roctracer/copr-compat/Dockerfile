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

RUN git clone https://src.fedoraproject.org/rpms/roctracer.git
RUN dnf --nogpgcheck -y builddep --with compat --with test roctracer/roctracer.spec
RUN spectool -g -R roctracer/roctracer.spec
RUN cp roctracer/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with compat --with test roctracer/roctracer.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash"]

