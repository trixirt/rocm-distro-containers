FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-bandwidth-test.git
RUN dnf -y builddep rocm-bandwidth-test/rocm-bandwidth-test.spec
RUN spectool -g -R rocm-bandwidth-test/rocm-bandwidth-test.spec
RUN cp -r rocm-bandwidth-test/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-bandwidth-test/rocm-bandwidth-test.spec

CMD ["bash"]