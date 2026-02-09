FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocm-rpm-macros.git
RUN dnf -y builddep rocm-rpm-macros/rocm-rpm-macros.spec
RUN rpmdev-setuptree
RUN cp rocm-rpm-macros/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-rpm-macros/rocm-rpm-macros.spec

CMD ["bash"]