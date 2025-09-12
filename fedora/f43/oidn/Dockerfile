FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/oidn.git
RUN dnf -y builddep oidn/oidn.spec
RUN spectool -g -R oidn/oidn.spec
RUN cp oidn/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba oidn/oidn.spec

CMD ["bash"]