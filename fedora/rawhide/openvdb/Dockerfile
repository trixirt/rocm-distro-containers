FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/openvdb.git
RUN dnf -y builddep openvdb/openvdb.spec
RUN spectool -g -R openvdb/openvdb.spec
RUN cp openvdb/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba openvdb/openvdb.spec

CMD ["bash"]