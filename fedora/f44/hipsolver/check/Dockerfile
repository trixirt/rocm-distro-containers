FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 hipsparse-devel \
 blas-static \
 lapack-static

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hipsolver.git
RUN dnf -y builddep hipsolver/hipsolver.spec
RUN spectool -g -R hipsolver/hipsolver.spec
RUN cp hipsolver/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test hipsolver/hipsolver.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/hipsolver*

CMD ["hipsolver-test"]