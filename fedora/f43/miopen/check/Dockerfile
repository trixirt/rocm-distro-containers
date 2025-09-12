FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
 gmock-devel \
 gtest-devel

RUN git clone https://src.fedoraproject.org/rpms/miopen.git
RUN dnf -y builddep miopen/miopen.spec
RUN spectool -g -R miopen/miopen.spec
RUN cp miopen/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test miopen/miopen.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["bash"]