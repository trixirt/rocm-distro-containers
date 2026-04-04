FROM ubuntu:26.04

RUN apt update
RUN apt install -y libhipcub-tests

# CMD ["/usr/libexec/rocm/libhipcub-tests/run-tests"]
CMD ["bash", "-c", "for f in /usr/libexec/rocm/libhipcub-tests/test_hipcub*; do $f; done"]

