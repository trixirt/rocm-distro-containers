FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocdecode.git
RUN dnf -y builddep rocdecode/rocdecode.spec
RUN spectool -g -R rocdecode/rocdecode.spec
RUN cp rocdecode/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocdecode/rocdecode.spec

CMD ["bash"]