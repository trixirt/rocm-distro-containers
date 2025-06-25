FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocsolver0
RUN git clone https://src.opensuse.org/ROCm/rocsolver.git
RUN cd rocsolver; git lfs pull
RUN cp -r rocsolver/* ~/rpmbuild/SOURCES
RUN cd rocsolver; rpmbuild -ba rocsolver.spec

CMD ["bash"]