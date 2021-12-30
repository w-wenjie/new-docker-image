FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu16.04

RUN rm -f /usr/lib/x86_64-linux-gnu/libnccl_static.a \
          /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a

# Install package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        libtool \
        pkg-config \
        ca-certificates \
        wget \
        git \
        python \
        python3 \
        python-dev \
        python3-dev \
        libprotobuf-dev \
        protobuf-compiler \
        cmake \
        swig \
    && rm -rf /var/lib/apt/lists/*

# Install pip
RUN cd /usr/local/src && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python2 get-pip.py && \
    pip2 install --upgrade pip && \
    python3 get-pip.py && \
    pip3 install --upgrade pip && \
    rm -f get-pip.py

# Build and install onnx
RUN cd /usr/local/src && \
    git clone --recurse-submodules https://github.com/onnx/onnx.git && \
    cd onnx && \
    git checkout dee6d89 && \
    pip2 install pybind11 && \
    pip2 install protobuf && \
    pip2 install numpy && \
    pip3 install numpy && \
    python setup.py build && \
    python setup.py install && \
    cd ../ && \
    rm -rf onnx/

