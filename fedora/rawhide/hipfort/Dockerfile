FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipfort.git
RUN dnf -y builddep hipfort/hipfort.spec
RUN spectool -g -R hipfort/hipfort.spec
RUN cp hipfort/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipfort/hipfort.spec

CMD ["bash"]