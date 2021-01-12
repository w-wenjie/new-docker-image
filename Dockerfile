FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libterm-readkey-perl dialog
RUN apt-get install -y --no-install-recommends make git wget curl gcc build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev && \
pip install numpy opencv-python tensorboard moviepy 'git+https://github.com/facebookresearch/fvcore' simplejson sklearn pandas && \
conda install av -c -y conda-forge && \
pip install -U cython && \
pip install -U 'git+https://github.com/facebookresearch/fvcore.git' && pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI' && \
git clone https://github.com/facebookresearch/detectron2 detectron2_repo && \
pip install -e detectron2_repo && \
python detectron2_repo/setup.py build develop
