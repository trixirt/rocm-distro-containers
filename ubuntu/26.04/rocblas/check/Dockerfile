FROM ubuntu:26.04

RUN apt update
RUN apt install -y librocblas5-tests

CMD ["/usr/libexec/rocm/librocblas5-tests/run-tests"]
