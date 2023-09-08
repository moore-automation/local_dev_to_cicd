FROM ciscotestautomation/pyats:latest

LABEL Author="edmoor@cisco.com" 
RUN \
  echo "===> Installing Ansible from apk..."  && \
  apk add --no-cache --update ansible bash

RUN \
  echo "===> Adding localhost ..."  && \
  mkdir /etc/ansible/ /ansible && \
  echo "[local]" >> /etc/ansible/hosts && \
  echo "localhost" >> /etc/ansible/hosts && \
  echo "===> Adding playbooks volume ..."  && \
  mkdir -p /ansible/playbooks

WORKDIR /ansible/playbooks

COPY /content/Ansible .
VOLUME /ansible/playbooks 
ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

CMD ["/bin/bash"]
