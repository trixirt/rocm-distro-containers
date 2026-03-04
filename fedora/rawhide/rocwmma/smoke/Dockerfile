FROM fedora:rawhide

RUN dnf update -y

RUN dnf install -y \
 gcc-c++ \
 git \
 rocm-hip-devel \
 rocminfo \
 rocwmma-devel

RUN git clone https://src.fedoraproject.org/rpms/rocwmma.git
WORKDIR /rocwmma

# On non MI systems, expect this
# /usr/include/rocwmma/internal/layout/../config.hpp:79:15: error: static assertion failed: Unsupported architecture
#   79 | static_assert(0, "Unsupported architecture");
#      |               ^

CMD ["bash", "test.sh"]
# CMD ["bash"]

