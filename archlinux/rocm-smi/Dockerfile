FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    cmake \
    python \
    libdrm \
    pciutils \
    libpciaccess

# Symlink headers so the build finds drm.h without issue
RUN ln -s /usr/include/libdrm/* /usr/include/

WORKDIR /opt
RUN git clone https://github.com/ROCm/amdsmi.git

WORKDIR /opt/amdsmi

# Apply patch: Redefinition Error
# Renaming the struct in local AMDSMI header to force compiler to use libdrm's official definition
RUN sed -i 's/struct drm_color_ctm_3x4/struct drm_color_ctm_3x4_IGNORE/' include/amd_smi/impl/amdgpu_drm.h

# Append the "Ignore Warnings" flags to the end of the config file.
RUN echo 'add_compile_options(-w -fpermissive -Wno-error)' >> CMakeLists.txt

# Build
RUN mkdir build && cd build && \
    cmake \
    -DBUILD_TESTS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    .. && \
    make

# Run the amdsmi test
CMD ["/opt/amdsmi/build/tests/amd_smi_test/amdsmitst"]
