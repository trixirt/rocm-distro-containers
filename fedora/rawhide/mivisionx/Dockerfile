FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/mivisionx.git
RUN dnf -y builddep mivisionx/mivisionx.spec
RUN spectool -g -R mivisionx/mivisionx.spec
RUN cp mivisionx/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba mivisionx/mivisionx.spec

CMD ["bash"]