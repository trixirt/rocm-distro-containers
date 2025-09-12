FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-cmake.git
RUN dnf -y builddep rocm-cmake/rocm-cmake.spec
RUN spectool -g -R rocm-cmake/rocm-cmake.spec
RUN cp rocm-cmake/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-cmake/rocm-cmake.spec

CMD ["bash"]