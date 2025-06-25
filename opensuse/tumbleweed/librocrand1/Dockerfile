FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d librocrand1

RUN git clone https://src.opensuse.org/ROCm/rocrand.git
RUN cd rocrand; git lfs pull
RUN cp -r rocrand/* ~/rpmbuild/SOURCES
RUN cd rocrand; rpmbuild -ba rocrand.spec

CMD ["bash"]