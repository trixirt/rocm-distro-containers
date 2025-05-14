FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblas-common.git
RUN dnf -y builddep hipblas-common/hipblas-common.spec
RUN spectool -g -R hipblas-common/hipblas-common.spec
RUN cp hipblas-common/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipblas-common/hipblas-common.spec

CMD ["bash"]