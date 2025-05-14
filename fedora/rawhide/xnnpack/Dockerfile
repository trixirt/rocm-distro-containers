FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/xnnpack.git
RUN dnf -y builddep xnnpack/xnnpack.spec
RUN spectool -g -R xnnpack/xnnpack.spec
RUN cp xnnpack/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba xnnpack/xnnpack.spec

CMD ["bash"]