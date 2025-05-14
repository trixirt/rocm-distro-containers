FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipify.git
RUN dnf -y builddep hipify/hipify.spec
RUN spectool -g -R hipify/hipify.spec
RUN cp hipify/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipify/hipify.spec

CMD ["bash"]