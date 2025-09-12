FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/cpuinfo.git
RUN dnf -y builddep cpuinfo/cpuinfo.spec
RUN spectool -g -R cpuinfo/cpuinfo.spec
RUN cp cpuinfo/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba cpuinfo/cpuinfo.spec

CMD ["bash"]