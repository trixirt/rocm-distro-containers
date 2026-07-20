FROM fedora:rawhide

RUN dnf update -y

RUN dnf config-manager addrepo --from-repofile=https://copr.fedorainfracloud.org/coprs/g/rocm-packagers-sig/preview/repo/fedora-rawhide/group_rocm-packagers-sig-preview-fedora-rawhide.repo
RUN dnf update --nogpgcheck -y

RUN dnf install -y \
 git \
 ninja-build \
 python3-yaml \
 rpm-build \
 rpmdevtools \
 rpmlint \
 rocminfo \
 time

RUN dnf -y builddep llama-cpp
RUN git clone https://github.com/ggerganov/llama.cpp

COPY build.sh build.sh

CMD ["bash", "build.sh"]
# CMD ["bash"]
