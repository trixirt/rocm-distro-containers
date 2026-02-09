FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocm-core.git
RUN dnf -y builddep rocm-core/rocm-core.spec
RUN spectool -g -R rocm-core/rocm-core.spec
RUN cp rocm-core/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-core/rocm-core.spec

CMD ["bash"]