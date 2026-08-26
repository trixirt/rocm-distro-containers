FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/roctracer.git
RUN dnf -y builddep --with test roctracer/roctracer.spec
RUN spectool -g -R roctracer/roctracer.spec
RUN cp -r roctracer/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test roctracer/roctracer.spec

RUN rpm -ihv --nosignature --nodeps ~/rpmbuild/RPMS/x86_64/roctracer*

COPY test.sh /test.sh

CMD ["bash", "/test.sh" ]
