FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocm-omp.git
RUN dnf -y builddep rocm-omp/rocm-omp.spec
RUN spectool -g -R rocm-omp/rocm-omp.spec
RUN cp rocm-omp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-omp/rocm-omp.spec

CMD ["bash"]