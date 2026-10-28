FROM fedora:45

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo

#
# Problem for rawhide gtest 1.17.0, fallback to f43
RUN git clone -b f43 https://src.fedoraproject.org/rpms/gtest.git
RUN dnf -y builddep gtest/gtest.spec
RUN spectool -g -R gtest/gtest.spec
RUN cp -r gtest/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gtest/gtest.spec
RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN git clone -b f45 https://src.fedoraproject.org/rpms/rccl.git
RUN dnf -y builddep --with test rccl/rccl.spec
RUN spectool -g -R rccl/rccl.spec
RUN cp -r rccl/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rccl/rccl.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/rccl*

COPY test.sh /

CMD ["/test.sh"]

# CMD ["bash"]



