FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocprim.git
RUN dnf -y builddep rocprim/rocprim.spec
RUN spectool -g -R rocprim/rocprim.spec
RUN cp rocprim/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocprim/rocprim.spec

CMD ["bash"]