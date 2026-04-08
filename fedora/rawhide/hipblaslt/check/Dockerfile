FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipblaslt.git
RUN dnf -y builddep --with test hipblaslt/hipblaslt.spec
RUN spectool -g -R hipblaslt/hipblaslt.spec
RUN cp hipblaslt/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test hipblaslt/hipblaslt.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["hipblaslt-test"]
