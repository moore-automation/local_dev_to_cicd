ARG ext_image_version


FROM $ext_image_version
LABEL authors="edmoor@cisco.com"
RUN apt-get update && apt-get -y install --no-install-recommends\
  apt-transport-https \
  ca-certificates \
  curl &&\
  rm -rf /var/lib/apt/lists/*

COPY build/gitlab/gitlab-entrypoint.sh build/gitlab/gitlab-wrapper.sh /
RUN chmod +x /gitlab-entrypoint.sh ; chmod +x /gitlab-wrapper.sh

ENTRYPOINT ["/gitlab-wrapper.sh"]