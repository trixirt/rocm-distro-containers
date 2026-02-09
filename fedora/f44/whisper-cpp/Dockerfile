FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone -b f44 https://src.fedoraproject.org/rpms/whisper-cpp.git
RUN dnf -y builddep whisper-cpp/whisper-cpp.spec
RUN spectool -g -R whisper-cpp/whisper-cpp.spec
RUN cp whisper-cpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba whisper-cpp/whisper-cpp.spec

CMD ["bash"]