FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocclr.git
RUN dnf -y builddep rocclr/rocclr.spec
RUN spectool -g -R rocclr/rocclr.spec
RUN cp -r rocclr/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocclr/rocclr.spec

CMD ["bash"]