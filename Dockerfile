FROM nvcr.io/nvidia/l4t-base:r32.6.1

RUN cd /opt/ && git clone https://github.com/microsoft/onnxruntime.git && \
    git checkout v0.5.0 && \
    sudo apt install -y --no-install-recommends && build-essential software-properties-common cmake libopenblas-dev libpython3.6-dev python3-pip python3-dev

RUN cd /opt/onnxruntime && \
    ./build.sh --update --config Release --build --build_wheel --use_cuda --cuda_home /usr/local/cuda --cudnn_home /usr/lib/aarch64-linux-gnu
