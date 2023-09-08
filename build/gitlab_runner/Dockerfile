ARG RUNNER_VERSION="gitlab-runner"
ARG TAG="latest"

FROM gitlab/$RUNNER_VERSION:$TAG
COPY /build/gitlab_runner/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN \
  echo "===> Update and curl Install..."  && \
  apt-get update && apt-get -y install --no-install-recommends\
  apt-transport-https \
  ca-certificates \
  curl \
  bash

ENTRYPOINT ["/docker-entrypoint.sh"]