FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

# RUN dnf install -y gtest-devel
#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone https://src.fedoraproject.org/rpms/hiprand.git
RUN dnf -y builddep hiprand/hiprand.spec
RUN spectool -g -R hiprand/hiprand.spec
RUN cp -r hiprand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test hiprand/hiprand.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/hiprand*

CMD ["bash", "-c", "for f in /usr/bin/test_hiprand*; do $f; done"]
