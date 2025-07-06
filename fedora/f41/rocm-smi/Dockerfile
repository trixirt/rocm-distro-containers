FROM fedora:41

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN rpmdev-setuptree

RUN git clone -b f41 https://src.fedoraproject.org/rpms/rocm-smi.git
RUN dnf -y builddep rocm-smi/rocm-smi.spec
RUN spectool -g -R rocm-smi/rocm-smi.spec
RUN cp rocm-smi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-smi/rocm-smi.spec

CMD ["bash"]