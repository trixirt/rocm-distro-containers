FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN git clone https://src.fedoraproject.org/rpms/whisper-cpp.git
RUN dnf -y builddep whisper-cpp/whisper-cpp.spec
RUN spectool -g -R whisper-cpp/whisper-cpp.spec
RUN cp whisper-cpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba whisper-cpp/whisper-cpp.spec

CMD ["bash"]