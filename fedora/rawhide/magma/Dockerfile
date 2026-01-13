FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/magma.git
RUN dnf -y builddep magma/magma.spec
RUN spectool -g -R magma/magma.spec
RUN cp magma/* ~/rpmbuild/SOURCES
# RUN rpmbuild -ba magma/magma.spec

CMD ["bash"]