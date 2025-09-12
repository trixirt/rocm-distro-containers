FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/roctracer.git
RUN dnf -y builddep roctracer/roctracer.spec
RUN spectool -g -R roctracer/roctracer.spec
RUN cp roctracer/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba roctracer/roctracer.spec

CMD ["bash"]