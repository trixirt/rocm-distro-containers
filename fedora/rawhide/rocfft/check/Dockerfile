FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo

RUN git clone https://src.fedoraproject.org/rpms/rocfft.git
RUN dnf -y builddep --with test rocfft/rocfft.spec
RUN spectool -g -R rocfft/rocfft.spec
RUN cp rocfft/* ~/rpmbuild/SOURCES

RUN rpmbuild -ba --with test rocfft/rocfft.spec

RUN dnf -y install ~/rpmbuild/RPMS/x86_64/rocfft-*

COPY test.sh /

CMD ["/test.sh"]

# CMD ["bash"]