FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/openvkl.git
RUN dnf -y builddep openvkl/openvkl.spec
RUN spectool -g -R openvkl/openvkl.spec
RUN cp openvkl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba openvkl/openvkl.spec

CMD ["bash"]