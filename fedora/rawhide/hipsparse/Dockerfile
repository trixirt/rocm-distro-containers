FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hipsparse.git
RUN dnf -y builddep hipsparse/hipsparse.spec
RUN spectool -g -R hipsparse/hipsparse.spec
RUN cp hipsparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hipsparse/hipsparse.spec

CMD ["bash"]