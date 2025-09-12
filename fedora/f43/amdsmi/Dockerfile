FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/amdsmi.git
RUN dnf -y builddep amdsmi/amdsmi.spec
RUN spectool -g -R amdsmi/amdsmi.spec
RUN cp amdsmi/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba amdsmi/amdsmi.spec

CMD ["bash"]