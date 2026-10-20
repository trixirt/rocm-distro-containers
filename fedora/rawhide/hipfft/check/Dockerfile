FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipfft.git
RUN dnf -y builddep --with test hipfft/hipfft.spec
RUN spectool -g -R hipfft/hipfft.spec
RUN cp hipfft/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test hipfft/hipfft.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/*

COPY test.sh /

CMD ["/test.sh"]
