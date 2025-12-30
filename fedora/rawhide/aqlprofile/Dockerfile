FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/aqlprofile.git
RUN dnf -y builddep aqlprofile/aqlprofile.spec
RUN spectool -g -R aqlprofile/aqlprofile.spec
RUN cp aqlprofile/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba aqlprofile/aqlprofile.spec

CMD ["bash"]