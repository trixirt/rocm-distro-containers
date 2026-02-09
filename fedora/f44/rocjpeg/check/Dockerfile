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
 rocprofiler-register-devel

RUN git clone -b f44 https://src.fedoraproject.org/rpms/rocjpeg.git
RUN dnf -y builddep rocjpeg/rocjpeg.spec
RUN spectool -g -R rocjpeg/rocjpeg.spec
RUN cp rocjpeg/* ~/rpmbuild/SOURCES
RUN rpmbuild -ba rocjpeg/rocjpeg.spec

# Need to install the samples
RUN rpm -ihv --nodeps ~/rpmbuild/RPMS/x86_64/*

CMD ["rpmbuild", "-ba", "--with", "check", "rocjpeg/rocjpeg.spec"]
# CMD ["bash"]