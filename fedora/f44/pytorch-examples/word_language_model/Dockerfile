FROM fedora:f44

RUN dnf update -y

RUN dnf install -y pytorch-examples python3-sympy

WORKDIR /usr/share/pytorch-examples/word_language_model

# MIOpen(HIP): Error [BuildHip] HIPRTC status = HIPRTC_ERROR_COMPILATION (6), source file: MIOpenDropoutHIP.cpp
# MIOpen(HIP): Warning [BuildHip] In file included from /tmp/comgr-78a343/input/MIOpenDropoutHIP.cpp:32:
# In file included from /tmp/comgr-78a343/include/miopen_rocrand.hpp:45:
# In file included from /usr/include/rocrand/rocrand_xorwow.h:24:
# /usr/include/rocrand/rocrand_common.h:39:10: fatal error: 'utility' file not found
#   39 | #include <utility>
#      |          ^~~~~~~~~
RUN dnf install -y gcc-c++

CMD ["python3", "main.py", "--cuda", "--epochs", "6"]
# CMD ["bash"]
