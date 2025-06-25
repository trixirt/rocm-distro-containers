FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d libhsa-runtime64-1
RUN git clone https://src.opensuse.org/ROCm/rocm-runtime.git
RUN cd rocm-runtime; git lfs pull
RUN cp -r rocm-runtime/* ~/rpmbuild/SOURCES
RUN cd rocm-runtime; rpmbuild -ba rocm-runtime.spec


CMD ["bash"]