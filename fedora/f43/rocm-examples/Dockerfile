FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-examples.git
RUN dnf -y builddep rocm-examples/rocm-examples.spec
RUN spectool -g -R rocm-examples/rocm-examples.spec
RUN cp rocm-examples/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-examples/rocm-examples.spec

CMD ["bash"]