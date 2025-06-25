FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocthrust
RUN git clone https://src.opensuse.org/ROCm/rocthrust.git
RUN cd rocthrust; git lfs pull
RUN cp -r rocthrust/* ~/rpmbuild/SOURCES
RUN cd rocthrust; rpmbuild -ba rocthrust.spec


CMD ["bash"]