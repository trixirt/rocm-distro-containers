FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/suitesparse.git
RUN dnf -y builddep suitesparse/suitesparse.spec
RUN spectool -g -R suitesparse/suitesparse.spec
RUN cp suitesparse/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba suitesparse/suitesparse.spec

CMD ["bash"]