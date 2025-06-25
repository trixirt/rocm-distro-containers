FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d rocm-rpm-macros
RUN git clone https://src.opensuse.org/ROCm/rocm-rpm-macros.git
RUN cd rocm-rpm-macros; git lfs pull
RUN cp -r rocm-rpm-macros/* ~/rpmbuild/SOURCES
RUN cd rocm-rpm-macros; rpmbuild -ba rocm-rpm-macros.spec

CMD ["bash"]