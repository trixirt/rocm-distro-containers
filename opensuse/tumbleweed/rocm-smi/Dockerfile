FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocm-smi

RUN git clone https://src.opensuse.org/ROCm/rocm-smi.git
RUN cd rocm-smi; git lfs pull
RUN cp -r rocm-smi/* ~/rpmbuild/SOURCES
RUN cd rocm-smi; rpmbuild -ba rocm-smi.spec

CMD ["bash"]