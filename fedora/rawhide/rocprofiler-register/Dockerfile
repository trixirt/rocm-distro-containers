FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocprofiler-register.git
RUN dnf -y builddep rocprofiler-register/rocprofiler-register.spec
RUN spectool -g -R rocprofiler-register/rocprofiler-register.spec
RUN cp rocprofiler-register/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocprofiler-register/rocprofiler-register.spec

CMD ["bash"]