FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/pocketfft.git
RUN dnf -y builddep pocketfft/pocketfft.spec
RUN spectool -g -R pocketfft/pocketfft.spec
RUN cp pocketfft/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba pocketfft/pocketfft.spec

CMD ["bash"]