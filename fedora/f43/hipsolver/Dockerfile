FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipsolver.git
RUN dnf -y builddep hipsolver/hipsolver.spec
RUN spectool -g -R hipsolver/hipsolver.spec
RUN cp hipsolver/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipsolver/hipsolver.spec

CMD ["bash"]