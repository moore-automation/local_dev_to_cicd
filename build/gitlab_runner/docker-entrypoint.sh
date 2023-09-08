#!/bin/bash

>&2 echo "Waiting for 2 minutes for Gitlab to initialise..."
sleep 120



while [  "$(curl $CI_SERVER_URL:80/-/health)"  != "GitLab OK" ]; do   echo "Waiting for gitlab services to come up..."
sleep 10
done

>&2 echo "Gitlab is up - executing commands"

>&2 echo "Registering runner"
gitlab-runner register \
--non-interactive \
--name $RUNNER_NAME \
--url $CLONE_URL \
--clone-url $CLONE_URL \
--registration-token $REGISTRATION_TOKEN \
--executor $RUNNER_EXECUTOR \
--shell $RUNNER_SHELL
--name $RUNNER_NAME \
--run-untagged="true" \
--locked="false" \
--access-level="not_protected" \

>&2 echo "Starting runner"
gitlab-runner run


tail -f /dev/null
