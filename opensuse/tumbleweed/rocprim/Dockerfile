FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocprim
RUN git clone https://src.opensuse.org/ROCm/rocprim.git
RUN cd rocprim; git lfs pull
RUN cp -r rocprim/* ~/rpmbuild/SOURCES
RUN cd rocprim; rpmbuild -ba rocprim.spec

CMD ["bash"]