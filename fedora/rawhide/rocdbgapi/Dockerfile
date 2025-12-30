FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocdbgapi.git
RUN dnf -y builddep rocdbgapi/rocdbgapi.spec
RUN spectool -g -R rocdbgapi/rocdbgapi.spec
RUN cp rocdbgapi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocdbgapi/rocdbgapi.spec

CMD ["bash"]