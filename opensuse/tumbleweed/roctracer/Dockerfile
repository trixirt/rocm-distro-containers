FROM opensuse/tumbleweed

RUN zypper -n install \
 git \
 git-lfs \
 rpmbuild \
 rpmdevtools \
 rpmlint

RUN rpmdev-setuptree

RUN zypper ar -G -f https://download.opensuse.org/repositories/science:/GPU:/ROCm/openSUSE_Tumbleweed/ rocm
RUN zypper -n si -d roctracer
RUN git clone https://src.opensuse.org/ROCm/roctracer.git
RUN cd roctracer; git lfs pull
RUN cp -r roctracer/* ~/rpmbuild/SOURCES
RUN cd roctracer; rpmbuild -ba roctracer.spec

CMD ["bash"]