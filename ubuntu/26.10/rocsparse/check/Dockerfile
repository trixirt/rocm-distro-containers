FROM ubuntu:26.10

RUN apt update
RUN apt install -y librocsparse1-tests

CMD ["/usr/libexec/rocm/librocsparse1-tests/run-tests"]
