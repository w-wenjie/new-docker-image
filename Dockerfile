FROM flink:1.14.0-scala_2.12-java11

ENV TZ=Asia/Shanghai

RUN set -ex; \
    apt-get update; \
    apt-get -y install python3; \
    apt-get -y install python3-pip; \
    apt-get -y install python3-dev; \
    ln -sf /usr/bin/python3 /usr/bin/python; \
    ln -sf /usr/bin/pip3 /usr/bin/pip; \
    apt-get update; \
    python -m pip install --upgrade pip

RUN pip install apache-flink==1.14.0

WORKDIR /opt/flink
