FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH /opt/slowfast:$PYTHONPATH

WORKDIR /opt

RUN apt-get update && apt-get upgrade -y && apt-get install -y libterm-readkey-perl dialog && \
apt-get install -y --no-install-recommends make git wget curl gcc build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libgl1-mesa-glx && \
pip install numpy flask opencv-python tensorboard moviepy 'git+https://github.com/facebookresearch/fvcore' simplejson sklearn pandas && \
conda install -y av -c conda-forge && \
pip install -U cython && \
pip install -U 'git+https://github.com/facebookresearch/fvcore.git' 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI' && \
git clone https://github.com/facebookresearch/detectron2 detectron2_repo && \
pip install -e detectron2_repo && \
git clone https://github.com/facebookresearch/slowfast && \
cd /opt/slowfast && \
python setup.py build develop && \
apt-get autoclean && \
find /opt/conda/lib/python3.7 -name '*.pyc' -delete && \
rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*


