FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 rocminfo

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone https://src.fedoraproject.org/rpms/rocprim.git
RUN dnf -y builddep rocprim/rocprim.spec
RUN spectool -g -R rocprim/rocprim.spec
RUN cp rocprim/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocprim/rocprim.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/rocprim*

CMD ["bash", "-c", "for f in /usr/bin/test_*; do $f; done"]
