FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rccl.git
RUN dnf -y builddep rccl/rccl.spec
RUN spectool -g -R rccl/rccl.spec
RUN cp rccl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rccl/rccl.spec

CMD ["bash"]