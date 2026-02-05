FROM archlinux:latest

RUN yes | pacman -Syu

RUN yes | pacman -S \
 base-devel \
 git \
 pkgfile \
 rocalution \
 rocm-toolchain \
 sed

RUN pkgfile --update

RUN git clone https://gitlab.archlinux.org/archlinux/packaging/packages/rocalution.git
WORKDIR rocalution

RUN sed -i '1a\export ROCM_PATH=/opt/rocm' test.sh
CMD ["bash", "test.sh"]
# CMD ["bash"]

