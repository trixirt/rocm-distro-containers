FROM archlinux:latest

RUN yes | pacman -Syu

# Remove check for running makepkg as root
RUN sed -i -e 's@EUID == 0@EUID == 1234567890@' /bin/makepkg

RUN yes | pacman -S \
 base-devel \
 binutils \
 debugedit \
 fakeroot \
 git \
 pkgfile

RUN pkgfile --update

RUN git clone https://gitlab.archlinux.org/archlinux/packaging/packages/hipify-clang.git
RUN cd hipify-clang; yes | makepkg -s

CMD ["bash"]

