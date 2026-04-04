FROM ubuntu:26.04

RUN apt update
RUN apt install -y llama.cpp-tests

CMD ["bash", "-c", "for f in /usr/libexec/x86_64-linux-gnu/llama.cpp-tests/test-*; do $f; done"]

# CMD ["bash"]

