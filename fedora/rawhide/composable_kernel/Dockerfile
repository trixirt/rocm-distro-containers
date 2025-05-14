FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/composable_kernel.git
RUN dnf -y builddep composable_kernel/composable_kernel.spec
RUN spectool -g -R composable_kernel/composable_kernel.spec
RUN cp composable_kernel/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba composable_kernel/composable_kernel.spec

CMD ["bash"]