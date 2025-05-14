FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf -y builddep hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp hipblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipblas/hipblas.spec

CMD ["bash"]