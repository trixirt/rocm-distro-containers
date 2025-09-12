FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-runtime.git
RUN dnf -y builddep rocm-runtime/rocm-runtime.spec
RUN spectool -g -R rocm-runtime/rocm-runtime.spec
RUN cp rocm-runtime/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-runtime/rocm-runtime.spec

CMD ["bash"]