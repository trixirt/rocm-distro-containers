FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocalution.git
RUN dnf -y builddep --with test rocalution/rocalution.spec
RUN spectool -g -R rocalution/rocalution.spec
RUN cp -r rocalution/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test rocalution/rocalution.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/roc*

CMD ["/usr/bin/rocalution-test"]
