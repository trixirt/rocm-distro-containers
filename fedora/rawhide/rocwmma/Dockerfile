FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocwmma.git
RUN dnf -y builddep rocwmma/rocwmma.spec
RUN spectool -g -R rocwmma/rocwmma.spec
RUN cp rocwmma/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocwmma/rocwmma.spec

CMD ["bash"]