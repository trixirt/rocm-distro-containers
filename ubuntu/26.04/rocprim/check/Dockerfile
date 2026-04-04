FROM ubuntu:26.04

RUN apt update
RUN apt install -y librocprim-tests

CMD ["/usr/libexec/rocm/librocprim-tests/run-tests"]
