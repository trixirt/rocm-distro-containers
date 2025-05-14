FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-triton.git
RUN dnf -y builddep python-triton/python-triton.spec
RUN spectool -g -R python-triton/python-triton.spec
RUN cp python-triton/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-triton/python-triton.spec

CMD ["bash"]