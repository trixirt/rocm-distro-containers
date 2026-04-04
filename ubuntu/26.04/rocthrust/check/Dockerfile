FROM ubuntu:26.04

RUN apt update
RUN apt install -y librocthrust-tests

# CMD ["/usr/libexec/rocm/librocthrust-tests/run-tests"]
CMD ["bash", "-c", "for f in /usr/libexec/rocm/librocthrust-tests/test_thrust*; do $f; done"]

