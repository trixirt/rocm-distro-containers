FROM fedora:rawhide

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
 rocblas-devel \
 libomp-devel

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN rpmbuild -ba --with test hipsparse/hipsparse.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/hipsparse*

# CMD ["hipsparse-test"]
CMD ["bash"]

