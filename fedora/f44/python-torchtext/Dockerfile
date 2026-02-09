FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/python-torchtext.git
RUN dnf -y builddep python-torchtext/python-torchtext.spec
RUN spectool -g -R python-torchtext/python-torchtext.spec
RUN cp python-torchtext/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-torchtext/python-torchtext.spec

CMD ["bash"]