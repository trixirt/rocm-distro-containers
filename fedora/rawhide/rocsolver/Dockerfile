FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocsolver.git
RUN dnf -y builddep rocsolver/rocsolver.spec
RUN spectool -g -R rocsolver/rocsolver.spec
RUN cp rocsolver/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocsolver/rocsolver.spec

CMD ["bash"]