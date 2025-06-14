FROM quay.io/centos/centos:stream10

RUN dnf update -y

RUN dnf install -y \
 git \
 rpm-build \
 rpmdevtools

RUN dnf install -y --skip-broken \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

RUN dnf update -y

RUN git clone -b epel10 https://src.fedoraproject.org/rpms/whisper-cpp.git
RUN dnf -y builddep whisper-cpp/whisper-cpp.spec
RUN spectool -g -R whisper-cpp/whisper-cpp.spec
RUN cp -r whisper-cpp/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba whisper-cpp/whisper-cpp.spec

CMD ["bash"]