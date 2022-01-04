FROM ubuntu:18.04

RUN cd /opt/ && git clone https://github.com/microsoft/onnxruntime.git && \
    git checkout v0.5.0 && \
    git submodule sync --recursive && \
    git submodule update --init --recursive

