FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/hip-tests.git
RUN dnf -y builddep hip-tests/hip-tests.spec
RUN spectool -g -R hip-tests/hip-tests.spec
RUN cp -r hip-tests/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba hip-tests/hip-tests.spec

CMD ["bash"]