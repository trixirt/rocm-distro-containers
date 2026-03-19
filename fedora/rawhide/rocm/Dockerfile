FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm.git
RUN dnf -y builddep rocm/rocm.spec
RUN spectool -g -R rocm/rocm.spec
RUN mkdir -p ~/rpmbuild/SOURCES
RUN cp -r rocm/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm/rocm.spec

CMD ["bash"]