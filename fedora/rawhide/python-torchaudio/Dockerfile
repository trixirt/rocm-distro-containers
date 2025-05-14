FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/python-torchaudio.git
RUN dnf -y builddep python-torchaudio/python-torchaudio.spec
RUN spectool -g -R python-torchaudio/python-torchaudio.spec
RUN cp python-torchaudio/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba python-torchaudio/python-torchaudio.spec

CMD ["bash"]