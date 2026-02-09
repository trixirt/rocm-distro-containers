FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/miopen.git
RUN dnf -y builddep miopen/miopen.spec
RUN spectool -g -R miopen/miopen.spec
RUN cp miopen/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba miopen/miopen.spec

CMD ["bash"]