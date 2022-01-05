FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git && \
    cd /opt/ && git clone https://github.com/microsoft/onnxruntime.git

RUN cd /opt/onnxruntime && git checkout v0.2.1 && \
    git submodule sync --recursive && \
    git submodule update --init --recursive

