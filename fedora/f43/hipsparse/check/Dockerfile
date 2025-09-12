FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipsparse.git
RUN dnf -y builddep hipsparse/hipsparse.spec
RUN spectool -g -R hipsparse/hipsparse.spec
RUN cp hipsparse/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 gtest-devel \
 rocblas-devel \
 libomp-devel

RUN rpmbuild -ba --with test hipsparse/hipsparse.spec

RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["hipsparse-test"]