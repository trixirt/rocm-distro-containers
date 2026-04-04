FROM ubuntu:26.04

RUN apt update
RUN apt install -y librocsolver0-tests

CMD ["/usr/libexec/rocm/librocsolver0-tests/run-tests"]
