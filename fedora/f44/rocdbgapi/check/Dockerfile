FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocdbgapi.git
RUN dnf -y builddep --with test rocdbgapi/rocdbgapi.spec
RUN spectool -g -R rocdbgapi/rocdbgapi.spec
RUN cp rocdbgapi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba --with test rocdbgapi/rocdbgapi.spec

CMD ["bash"]