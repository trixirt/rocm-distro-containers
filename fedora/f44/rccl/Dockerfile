FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rccl.git
RUN dnf -y builddep rccl/rccl.spec
RUN spectool -g -R rccl/rccl.spec
RUN cp rccl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rccl/rccl.spec

CMD ["bash"]