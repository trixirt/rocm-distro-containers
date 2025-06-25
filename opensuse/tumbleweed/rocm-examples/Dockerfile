FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocm-examples
RUN git clone https://src.opensuse.org/ROCm/rocm-examples.git
RUN cd rocm-examples; git lfs pull
RUN cp -r rocm-examples/* ~/rpmbuild/SOURCES
RUN cd rocm-examples; rpmbuild -ba rocm-examples.spec

CMD ["bash"]