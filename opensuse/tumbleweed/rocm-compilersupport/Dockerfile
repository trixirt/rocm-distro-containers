FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocm-compilersupport
RUN git clone https://src.opensuse.org/ROCm/rocm-compilersupport.git
RUN cd rocm-compilersupport; git lfs pull
RUN cp -r rocm-compilersupport/* ~/rpmbuild/SOURCES
RUN cd rocm-compilersupport; rpmbuild -ba rocm-compilersupport.spec

CMD ["bash"]