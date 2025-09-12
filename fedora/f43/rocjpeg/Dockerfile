FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocjpeg.git
RUN dnf -y builddep rocjpeg/rocjpeg.spec
RUN spectool -g -R rocjpeg/rocjpeg.spec
RUN cp rocjpeg/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocjpeg/rocjpeg.spec

CMD ["bash"]