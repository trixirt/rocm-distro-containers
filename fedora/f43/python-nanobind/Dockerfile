FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-nanobind.git
RUN dnf -y builddep python-nanobind/python-nanobind.spec
RUN spectool -g -R python-nanobind/python-nanobind.spec
RUN cp python-nanobind/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-nanobind/python-nanobind.spec

CMD ["bash"]