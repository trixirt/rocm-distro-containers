FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipcub.git
RUN dnf -y builddep hipcub/hipcub.spec
RUN spectool -g -R hipcub/hipcub.spec
RUN cp hipcub/* ~/rpmbuild/SOURCES

RUN dnf install -y \
 gtest-devel \
 rocminfo

CMD ["rpmbuild", "-ba", "--with", "check", "hipcub/hipcub.spec"]