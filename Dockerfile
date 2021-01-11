FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime

RUN apt-get update && apt-get upgrade -y && apt-get install -y dialog make git wget curl && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends && \
build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev gcc && \
pip install numpy opencv-python tensorboard moviepy 'git+https://github.com/facebookresearch/fvcore' simplejson sklearn pandas && \
conda install av -c conda-forge && \
pip install -U cython && \
pip install -U 'git+https://github.com/facebookresearch/fvcore.git' && 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI' && \
git clone https://github.com/facebookresearch/detectron2 detectron2_repo && \
pip install -e detectron2_repo && \
python setup.py build develop
