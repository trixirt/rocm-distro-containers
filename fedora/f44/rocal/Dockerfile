FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocal.git
RUN dnf -y builddep rocal/rocal.spec
RUN spectool -g -R rocal/rocal.spec
RUN cp rocal/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocal/rocal.spec

CMD ["bash"]