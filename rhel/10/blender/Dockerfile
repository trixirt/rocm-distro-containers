FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/blender.git
RUN dnf -y builddep blender/blender.spec
RUN spectool -g -R blender/blender.spec
RUN cp -r blender/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba blender/blender.spec

CMD ["bash"]