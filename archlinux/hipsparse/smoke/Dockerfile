FROM archlinux:latest

RUN yes | pacman -Syu

RUN yes | pacman -S \
 base-devel \
 git \
 pkgfile \
 hipsparse \
 rocm-toolchain \
 sed

RUN pkgfile --update

RUN git clone https://gitlab.archlinux.org/archlinux/packaging/packages/hipsparse.git
WORKDIR hipsparse

RUN sed -i '1a\export ROCM_PATH=/opt/rocm' test.sh
CMD ["bash", "test.sh"]
# CMD ["bash"]

