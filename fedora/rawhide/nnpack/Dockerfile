FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/nnpack.git
RUN dnf -y builddep nnpack/nnpack.spec
RUN spectool -g -R nnpack/nnpack.spec
RUN cp nnpack/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba nnpack/nnpack.spec

CMD ["bash"]