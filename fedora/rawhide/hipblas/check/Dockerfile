FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblas.git
RUN dnf -y builddep --with test hipblas/hipblas.spec
RUN spectool -g -R hipblas/hipblas.spec
RUN cp hipblas/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test hipblas/hipblas.spec
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/hipblas*

CMD ["hipblas-test"]

# CMD ["bash"]

# CMD ["gdb", "hipblas-test"]
