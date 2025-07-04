FROM fedora:42

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f42 https://src.fedoraproject.org/rpms/rocm-smi.git
RUN dnf -y builddep rocm-smi/rocm-smi.spec
RUN spectool -g -R rocm-smi/rocm-smi.spec
RUN cp rocm-smi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-smi/rocm-smi.spec

CMD ["bash"]