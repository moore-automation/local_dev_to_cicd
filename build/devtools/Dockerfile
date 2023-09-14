FROM ubuntu:latest

LABEL Author="edmoor@cisco.com" 


ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

RUN \
  echo "===> Update and Install packages..."  && \
  apt-get update && apt-get -y install --no-install-recommends\
  apt-transport-https \
  ca-certificates \
  curl \
  bash \
  ansible \
  gcc \
  python3-dev \
  python3-pip && \
  rm -rf /var/lib/apt/lists/* && \
  echo "===> Adding localhost ..."  && \
  mkdir /etc/ansible/ /ansible && \
  echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts && \
  echo "===> Adding playbooks volume ..."  && \
  mkdir -p /ansible/playbooks && \
  pip3 install pyats

WORKDIR /ansible/playbooks

COPY /content/Ansible .
VOLUME /ansible/playbooks 

CMD ["/bin/bash"]
