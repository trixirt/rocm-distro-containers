FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/python-logdetective.git
RUN dnf -y builddep python-logdetective/python-logdetective.spec
RUN spectool -g -R python-logdetective/python-logdetective.spec
RUN cp python-logdetective/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-logdetective/python-logdetective.spec

CMD ["bash"]