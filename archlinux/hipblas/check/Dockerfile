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

# RUN git clone https://gitlab.archlinux.org/archlinux/packaging/packages/hipblas.git

RUN git clone -b test https://gitlab.archlinux.org/trix/hipblas.git

RUN cd hipblas; yes | makepkg -s
RUN cd hipblas; yes | pacman -U *.zst

CMD ["bash", "-c", "cd hipblas; ./test.sh" ]

