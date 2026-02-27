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
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone https://src.fedoraproject.org/rpms/rocwmma.git
RUN dnf -y builddep --with test rocwmma/rocwmma.spec
RUN spectool -g -R rocwmma/rocwmma.spec
RUN cp rocwmma/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocwmma/rocwmma.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/rocwmma*
RUN dnf install -y libomp

CMD ["bash", "-c", "for f in /usr/bin/*_test; do $f; done"]
# CMD ["bash"]
