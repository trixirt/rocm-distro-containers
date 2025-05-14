FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocm-rpp.git
RUN dnf -y builddep rocm-rpp/rocm-rpp.spec
RUN spectool -g -R rocm-rpp/rocm-rpp.spec
RUN cp rocm-rpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocm-rpp/rocm-rpp.spec

CMD ["bash"]