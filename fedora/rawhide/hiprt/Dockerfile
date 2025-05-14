FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hiprt.git
RUN dnf -y builddep hiprt/hiprt.spec
RUN spectool -g -R hiprt/hiprt.spec
RUN cp hiprt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hiprt/hiprt.spec

CMD ["bash"]