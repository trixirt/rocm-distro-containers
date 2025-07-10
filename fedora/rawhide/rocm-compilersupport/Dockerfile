FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-compilersupport.git
RUN dnf -y builddep rocm-compilersupport/rocm-compilersupport.spec
RUN spectool -g -R rocm-compilersupport/rocm-compilersupport.spec
RUN cp -r rocm-compilersupport/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-compilersupport/rocm-compilersupport.spec

CMD ["bash"]