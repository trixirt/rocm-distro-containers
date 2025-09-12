FROM fedora:43

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-tensile.git
RUN dnf -y builddep python-tensile/python-tensile.spec
RUN spectool -g -R python-tensile/python-tensile.spec
RUN cp python-tensile/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-tensile/python-tensile.spec

CMD ["bash"]