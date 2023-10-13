ARG RUNNER_VERSION="gitlab-runner"
ARG TAG="latest"

FROM gitlab/$RUNNER_VERSION:$TAG
COPY /build/gitlab_runner/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN \
  echo "===> Update and Install packages..."  && \
  apt-get update && apt-get -y install --no-install-recommends\
  ca-certificates \
  ansible \
  gcc \
  python3-dev \
  python3-pip && \
  rm -rf /var/lib/apt/lists/* && \
  echo "===> Adding localhost ..."  && \
  mkdir -p /etc/ansible/ /ansible && \
  echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts && \
  echo "===> Adding playbooks volume ..."  && \
  pip3 install pyats netmiko paramiko && \
  ansible-galaxy collection install cisco.ios

ENTRYPOINT ["/docker-entrypoint.sh"]