FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/blender.git
RUN dnf -y builddep blender/blender.spec
RUN spectool -g -R blender/blender.spec
RUN cp blender/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba blender/blender.spec

CMD ["bash"]