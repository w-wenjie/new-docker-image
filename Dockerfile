FROM python:3.7

RUN wget https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.xz -O /usr/local && \
tar -xvf /usr/local/node-v14.15.1-linux-x64.tar.xz -C /usr/local && \
mv /usr/local/node-v14.15.1-linux-x64 /usr/local/nodejs && \
ln -s /usr/local/nodejs/bin/node /usr/bin/node && \
ln -s /usr/local/nodejs/bin/npm /usr/bin/npm && \
mkdir -p /user_file/data /user_file/model /user_file/code /user_file/.pip && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends libgl1-mesa-glx vim && \
pip install jupyterlab==2.2.9 tensorflow==1.14.0 numpy==1.16.0 jupyterlab-git && \
apt-get autoclean && \
find /usr/local/lib/python3.7 -name '*.pyc' -delete && \
rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/* && \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo 'Asia/Shanghai' >/etc/timezone && \
groupadd guest && \
useradd -g guest -d /user_file -m guest -s /bin/bash && \
chmod -R 777 /user_file && \
jupyter labextension install @jupyterlab/toc && \
jupyter lab build --dev-build=False --minimize=False

USER guest

WORKDIR /user_file

