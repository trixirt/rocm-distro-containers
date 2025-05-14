FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-rpm-macros.git
RUN dnf -y builddep rocm-rpm-macros/rocm-rpm-macros.spec
RUN spectool -g -R rocm-rpm-macros/rocm-rpm-macros.spec
RUN cp rocm-rpm-macros/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-rpm-macros/rocm-rpm-macros.spec

CMD ["bash"]