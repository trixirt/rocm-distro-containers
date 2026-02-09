FROM fedora:f44

RUN dnf update -y

RUN dnf install -y \
 fedora-review \
 git \
 rpm-build \
 rpmdevtools \
 rpmlint

RUN dnf install -y \
  ffmpeg-free \
  libavcodec-free-devel \
  libavformat-free-devel \
  libavutil-free-devel \
  rocprofiler-devel \

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocdecode.git
RUN dnf -y builddep rocdecode/rocdecode.spec
RUN spectool -g -R rocdecode/rocdecode.spec
RUN cp rocdecode/* ~/rpmbuild/SOURCES
# Need to install the samples first
RUN rpmbuild -ba rocdecode/rocdecode.spec
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rpmbuild", "-ba", "--with", "check", "rocdecode/rocdecode.spec" ]