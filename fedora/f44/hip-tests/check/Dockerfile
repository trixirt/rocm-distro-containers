FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/hip-tests.git
RUN dnf -y builddep --with check hip-tests/hip-tests.spec
RUN spectool -g -R hip-tests/hip-tests.spec
RUN cp -r hip-tests/* ~/rpmbuild/SOURCES

CMD ["rpmbuild", "-ba", "--with", "check", "hip-tests/hip-tests.spec" ]

