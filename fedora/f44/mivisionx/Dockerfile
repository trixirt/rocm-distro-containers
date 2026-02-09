FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/mivisionx.git
RUN dnf -y builddep mivisionx/mivisionx.spec
RUN spectool -g -R mivisionx/mivisionx.spec
RUN cp mivisionx/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba mivisionx/mivisionx.spec

CMD ["bash"]