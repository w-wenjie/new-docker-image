FROM python:3.7

LABEL author="wwj" description="在阿里云镜像服务里构建jupyterlab基础镜像" version="1.0"

RUN wget -q https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.xz -O /usr/local/node-v14.15.1-linux-x64.tar.xz && \
tar -xf /usr/local/node-v14.15.1-linux-x64.tar.xz -C /usr/local > /dev/null && \
mv /usr/local/node-v14.15.1-linux-x64 /usr/local/nodejs && \
ln -s /usr/local/nodejs/bin/node /usr/bin/node && \
ln -s /usr/local/nodejs/bin/npm /usr/bin/npm && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends libgl1-mesa-glx vim && \
pip install jupyterlab==2.2.9 jupyterlab-git python-language-server[python] && \
apt-get autoclean && \
find /usr/local/lib/python3.7 -name '*.pyc' -delete && \
rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/* && \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo 'Asia/Shanghai' >/etc/timezone && \
jupyter labextension install @jupyterlab/toc && \
#jupyter labextension install jupyterlab-drawio && \
jupyter labextension install @lckr/jupyterlab_variableinspector && \
jupyter labextension install @krassowski/jupyterlab-lsp && \
#jupyter labextension install nbgather && \
jupyter lab build --dev-build=False --minimize=False && \
git config --global http.sslverify false && \
git config --global https.sslverify false
