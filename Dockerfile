FROM nvcr.io/nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

LABEL author="wwj" description="使用ubuntu18.04 + miniconda 构建jupyterlab-gpu-cuda10.0基础镜像" version="1.0"

RUN for i in $(ls /etc/apt/sources.list.d); do  sed -i "s/^/#&/g" /etc/apt/sources.list.d/${i}; done && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends libgl1-mesa-glx vim wget git tzdata xz-utils zip unzip && \
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
wget -q https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.xz -O /usr/local/node-v14.15.1-linux-x64.tar.xz && \
echo "channels:" > /root/.condarc && \
echo "  - default" >> /root/.condarc && \
echo "envs_dirs:" >> /root/.condarc && \
echo "  - /home/guest/conda" >> /root/.condarc && \
echo "pkgs_dirs:" >> /root/.condarc && \
echo "  - /home/guest/conda/pkgs" >> /root/.condarc && \
echo "auto_activate_base: false" >> /root/.condarc && \
echo "env_prompt: '({name})'" >> /root/.condarc && \
tar -xf /usr/local/node-v14.15.1-linux-x64.tar.xz -C /usr/local > /dev/null && \
mv /usr/local/node-v14.15.1-linux-x64 /usr/local/nodejs && \
ln -s /usr/local/nodejs/bin/node /usr/bin/node && \
ln -s /usr/local/nodejs/bin/npm /usr/bin/npm && \
npm config set registry http://10.8.201.44:8081/repository/npm-group/ && \
groupadd guest && \
useradd -g guest -d /home/guest -m guest -s /bin/bash && \
echo "alias l='ls -ltra'" >> /home/guest/.bashrc && \
echo "PS1='[\$PWD]'" >> /home/guest/.bashrc && \
echo "alias l='ls -ltra'" >> /root/.bashrc && \
echo "PS1='[\$PWD]'" >> /root/.bashrc && \
mkdir -p /home/guest/conda/pkgs /home/guest/user_data && \
echo "export PATH=/opt/miniconda/bin/:$PATH" >> /home/guest/.bashrc && \
echo "export PATH=/opt/miniconda/bin/:$PATH" >> /root/.bashrc && \
echo "source activate virtualenv" >> /home/guest/.bashrc && \
bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
/opt/miniconda/bin/conda create -n virtualenv python=3.7 && \
/bin/bash -c "source /opt/miniconda/bin/activate virtualenv && pip install jupyterlab==3.0.5 notebook==6.2.0 qtconsole==5.0.1 ipywidgets==7.6.3 xeus-python==0.9.1 jupyterlab-lsp==3.1.0 python-language-server[all]==0.36.2 jupyterlab-git==0.30.0b1 -i https://pypi.douban.com/simple/" && \
apt-get autoclean && \
find /home/guest/conda/virtualenv/lib/python3.7 -name '*.pyc' -delete && \
rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*

RUN /bin/bash -c "source /opt/miniconda/bin/activate virtualenv && jupyter lab build --dev-build=False --minimize=False"

RUN echo "[http]" > /root/.gitconfig && \
echo "        sslverify = false" >> /root/.gitconfig && \
echo "[https]" >> /root/.gitconfig && \
echo "        sslverify = false" >> /root/.gitconfig && \
echo "[http]" > /home/guest/.gitconfig && \
echo "        sslverify = false" >> /home/guest/.gitconfig && \
echo "[https]" >> /home/guest/.gitconfig && \
echo "        sslverify = false" >> /home/guest/.gitconfig && \
ln -s /usr/local/cuda /usr/local/nvidia && \
find /home/guest/conda -name '*.pyc' -delete && \
rm -rf /usr/local/share/.cache/yarn/* /usr/local/node-v14.15.1-linux-x64.tar.xz && \
chown -R guest:guest /home/guest

ENV TZ Asia/Shanghai
ENV SHELL /bin/bash

