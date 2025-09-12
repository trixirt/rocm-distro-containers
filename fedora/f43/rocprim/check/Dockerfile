FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 gtest-devel \
 rocminfo

RUN git clone https://src.fedoraproject.org/rpms/rocprim.git
RUN dnf -y builddep rocprim/rocprim.spec
RUN spectool -g -R rocprim/rocprim.spec
RUN cp rocprim/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocprim/rocprim.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash", "-c", "for f in /usr/bin/test_*; do $f; done"]
