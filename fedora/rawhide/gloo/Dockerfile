FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/gloo.git
RUN dnf -y builddep gloo/gloo.spec
RUN spectool -g -R gloo/gloo.spec
RUN cp gloo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba gloo/gloo.spec

CMD ["bash"]