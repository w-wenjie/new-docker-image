FROM python:3.8
# FROM tensorflow/tensorflow:1.15.0-py3-jupyter
# FROM tensorflow/tensorflow:1.15.0-gpu-py3-jupyter
# FROM tensorflow/tensorflow:2.2.1-py3-jupyter
# FROM tensorflow/tensorflow:2.2.1-gpu-py3-jupyter

LABEL author="wwj" description="在阿里云镜像服务里构建jupyterlab基础镜像" version="1.0"

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 && \
apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends libgl1-mesa-glx vim wget git && \
wget -q https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.xz -O /usr/local/node-v14.15.1-linux-x64.tar.xz && \
tar -xf /usr/local/node-v14.15.1-linux-x64.tar.xz -C /usr/local > /dev/null && \
mv /usr/local/node-v14.15.1-linux-x64 /usr/local/nodejs && \
ln -s /usr/local/nodejs/bin/node /usr/bin/node && \
ln -s /usr/local/nodejs/bin/npm /usr/bin/npm && \
pip install jupyterlab==2.2.9 jupyterlab-git jupyter-lsp python-language-server[all] && \
pip install torch torchvision
apt-get autoclean && \
find /usr/local/lib/python3.8 -name '*.pyc' -delete && \
rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/* && \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo 'Asia/Shanghai' >/etc/timezone && \
jupyter labextension install @jupyterlab/toc && \
jupyter labextension install @lckr/jupyterlab_variableinspector && \
jupyter labextension install @krassowski/jupyterlab-lsp && \
# jupyter labextension install jupyterlab-drawio && \
# jupyter labextension install nbgather && \
jupyter lab build --dev-build=False --minimize=False && \
git config --global http.sslverify false && \
git config --global https.sslverify false

# nbgather: 清理代码，恢复丢失的代码以及比较代码版本的工具。
# @krassowski/jupyterlab-lsp: 用于自动补全、参数建议、函数文档查询、跳转定义等。
# @lckr/jupyterlab_variableinspector: 展示代码中的变量及其属性。
# jupyterlab-drawio: 绘图工具。
# @jupyterlab/toc: 目录插件

