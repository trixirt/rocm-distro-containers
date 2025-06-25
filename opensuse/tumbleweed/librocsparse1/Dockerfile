FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocsparse1
RUN git clone https://src.opensuse.org/ROCm/rocsparse.git
RUN cd rocsparse; git lfs pull
RUN cp -r rocsparse/* ~/rpmbuild/SOURCES
RUN cd rocsparse; rpmbuild -ba rocsparse.spec


CMD ["bash"]