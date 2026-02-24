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

RUN git clone https://src.fedoraproject.org/rpms/aqlprofile.git
RUN dnf --nogpgcheck -y builddep --with compat --with test aqlprofile/aqlprofile.spec
RUN spectool -g -R aqlprofile/aqlprofile.spec
RUN cp aqlprofile/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with compat --with test aqlprofile/aqlprofile.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash"]

