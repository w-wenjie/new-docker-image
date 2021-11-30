FROM node:10.16.3

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends openssh-server tzdata net-tools
RUN mkdir -p /var/run/sshd /root/.ssh

ENV TZ Asia/Shanghai

#ADD sshd_config /etc/ssh/sshd_config
#ADD authorized_keys /root/.ssh/authorized_keys
#ADD run.sh /run.sh
RUN echo root:123456 | chpasswd && \
    mkdir /opt/project && \
    npm install azure-pipelines-task-lib/task && \
    npm install azure-pipelines-task-lib/toolrunner

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
