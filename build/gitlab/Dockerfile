ARG ext_image_version


FROM $ext_image_version
LABEL authors="edmoor@cisco.com"

COPY build/gitlab/gitlab-entrypoint.sh build/gitlab/gitlab-wrapper.sh /
RUN chmod +x /gitlab-entrypoint.sh ; chmod +x /gitlab-wrapper.sh

ENTRYPOINT ["/gitlab-wrapper.sh"]