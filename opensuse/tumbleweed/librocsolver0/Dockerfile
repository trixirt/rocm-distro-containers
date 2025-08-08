FROM opensuse/tumbleweed

## Install base system
RUN zypper -n install \
   rpm-build \
   build-compare \
   compat-usrmerge-tools \
   compat-usrmerge-build \
   rpmlint-mini \
   brp-check-suse \
   gzip \
   less \
   post-build-checks \
   strace \
   build-mkbaselibs \
   gdb \
   vim \
   gcc-PIE \
   ncurses-utils \
   kernel-obs-build
#  git \
#  git-lfs \
#  rpmbuild \
#  rpmdevtools \
#  rpmlint \

## Install osc components
RUN zypper -n in --no-recommends obs-service-download_files;
COPY .rpmmacros .rpmrc /root/

# RUN rpmdev-setuptree

## Install build dependencies
RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm:/Work/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocsolver0

## Get package sources
RUN git clone https://src.opensuse.org/ROCmWork/rocsolver.git
### Ugly hack - we cannot run `osc service run download_files` w/o having an OBS password in the container
RUN cd rocsolver; /usr/lib/obs/service/download_files --enforceupstream yes --outdir $(pwd)

## Start build
RUN cd rocsolver; \
    rpmbuild -ba --define '_srcdefattr (-,root,root)' \
    --define "_sourcedir $(pwd)" \
    --define '_build_create_debug 1' \
    --nosignature \
    rocsolver.spec

CMD ["bash"]
