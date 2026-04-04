FROM ubuntu:26.04

RUN apt update
RUN apt install -y libmiopen1-tests

CMD ["/usr/libexec/rocm/libmiopen1-tests/miopen_gtest"]

