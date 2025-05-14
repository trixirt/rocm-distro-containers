FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocblas.git
RUN dnf -y builddep rocblas/rocblas.spec
RUN spectool -g -R rocblas/rocblas.spec
RUN cp rocblas/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocblas/rocblas.spec

CMD ["bash"]