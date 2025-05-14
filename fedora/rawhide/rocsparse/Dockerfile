FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocsparse.git
RUN dnf -y builddep rocsparse/rocsparse.spec
RUN spectool -g -R rocsparse/rocsparse.spec
RUN cp rocsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocsparse/rocsparse.spec

CMD ["bash"]