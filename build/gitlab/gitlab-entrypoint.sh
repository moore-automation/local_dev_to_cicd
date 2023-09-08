#!/bin/bash

while [  "$(curl $GITLAB_URL:80/-/health)"  != "GitLab OK" ]; do   echo "Waiting for gitlab services to come up..."
    sleep 10
done

>&2 echo "Gitlab is up - creating default user"

cd /
mkdir -p /scripts
echo 'u = User.new(username: ENV["DEFAULT_USER"], email: ENV["DEFAULT_EMAIL"], name: ENV["DEFAULT_NAME"], password: ENV["DEFAULT_PASS"], password_confirmation: ENV["DEFAULT_PASS"])
u.skip_confirmation!
u.save!
settings = Gitlab::CurrentSettings.current_application_settings
settings.allow_local_requests_from_web_hooks_and_services=TRUE
settings.save!
token = User.find_by_username("default_user").personal_access_tokens.create(scopes: [:api, :read_api], name: "Automation token")
token.set_token(ENV["API_TOKEN"])
token.save!' >> /scripts/default_user.rb
chown -R git:git /scripts && chmod 700 /scripts
gitlab-rails runner /scripts/default_user.rb
rm -r /scripts

>&2 echo "Default user created - initializing default project"

cd /home/data/
git init 
git add . 
git config --global user.email $DEFAULT_EMAIL 
git config --global user.name $DEFAULT_USER
git commit -m 'Initial Commit'
git push --set-upstream http://$DEFAULT_USER:$DEFAULT_PASS@$GITLAB_HOST:80/$DEFAULT_USER/$DEFAULT_PROJECT_NAME.git $DEFAULT_BRANCH_NAME

>&2 echo "GitLab is up"