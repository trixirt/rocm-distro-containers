FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hiprand.git
RUN dnf -y builddep hiprand/hiprand.spec
RUN spectool -g -R hiprand/hiprand.spec
RUN cp -r hiprand/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hiprand/hiprand.spec

CMD ["bash"]