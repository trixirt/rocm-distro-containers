FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocminfo
RUN git clone https://src.opensuse.org/ROCm/rocminfo.git
RUN cd rocminfo; git lfs pull
RUN cp -r rocminfo/* ~/rpmbuild/SOURCES
RUN cd rocminfo; rpmbuild -ba rocminfo.spec

CMD ["bash"]