FROM ubuntu:26.04

RUN apt update
RUN apt install -y libhipblas3-tests

CMD ["/usr/libexec/rocm/libhipblas3-tests/run-tests"]
