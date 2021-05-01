# Filename: Dockerfile
FROM centos:centos7

LABEL maintainer="github.com/saintdle"

ENV YQ_VERSION=v4.4.1
ENV YQ_BINARY=yq_linux_amd64
ENV HELM_VER=3.5.4

COPY kubernetes.repo /etc/yum.repos.d/

RUN   yum install epel-release -yq && \
      yum install -yq jq kubectl expect curl wget git openssl less glibc python python-pip mailcap && \
      wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -O /usr/bin/yq && \
      chmod +x /usr/bin/yq  && \
      wget -q https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz && \
      tar -zxvf helm-v${HELM_VER}-linux-amd64.tar.gz && \
      mv -f linux-amd64/helm /usr/local/bin/helm && \
      pip install --upgrade awscli==1.18.32 s3cmd==2.0.2 python-magic && \
      curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp && \
      mv /tmp/eksctl /usr/local/bin && \
      yum clean all
