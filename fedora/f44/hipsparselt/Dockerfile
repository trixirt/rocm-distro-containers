FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hipsparselt.git
RUN dnf -y builddep hipsparselt/hipsparselt.spec
RUN spectool -g -R hipsparselt/hipsparselt.spec
RUN cp hipsparselt/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipsparselt/hipsparselt.spec

CMD ["bash"]