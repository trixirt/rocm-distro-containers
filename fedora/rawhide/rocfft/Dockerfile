FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/rocfft.git
RUN dnf -y builddep rocfft/rocfft.spec
RUN spectool -g -R rocfft/rocfft.spec
RUN cp rocfft/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocfft/rocfft.spec

CMD ["bash"]