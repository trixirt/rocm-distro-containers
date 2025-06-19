FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocthrust.git
RUN dnf -y builddep rocthrust/rocthrust.spec
RUN spectool -g -R rocthrust/rocthrust.spec
RUN cp rocthrust/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 gtest-devel \
 rocminfo

CMD ["rpmbuild", "-ba", "--with", "check", "rocthrust/rocthrust.spec"]
