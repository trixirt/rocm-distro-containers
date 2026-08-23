FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-rpp.git
RUN dnf -y builddep rocm-rpp/rocm-rpp.spec
RUN spectool -g -R rocm-rpp/rocm-rpp.spec
RUN cp rocm-rpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocm-rpp/rocm-rpp.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

RUN dnf install -y pip python3-pandas

COPY test.sh /test.sh

CMD ["bash", "test.sh" ]