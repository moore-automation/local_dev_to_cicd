## All hands on GitLab
From the root of the cloned repository, bring up the containers using docker compose as described in the Readme file of the repo:

This project is extremely simple, it requires only docker to be installed on the host and this repository to be cloned or manually copied. *default today is compose version 2*

**You might have to change the `EXT_IMG_VERSION_GITLAB` variable in the `.env` file in this repository, depending on what's your processors architecture!**

1. To start the service simply run either of the following:
   1. (Version 1) ```docker-compose up -d```
   2. (Version 2+) ```docker compose up -d```
2. Check containers are spinning up
3. Go have a cup of tea for 5 minutes while gitlab get's ready.
4. Access gitlab in your browser : http://localhost:2080
5. Access devtools from cli : ```docker exec -it engine_devtools bash```

Should look something like this:

![docker_startup](assets/run.gif)

Once all the containers are up and running, you  got yourself a great automation toolset and a GitLab instance of your own! All inclusive a GitLab runner that will take care of the execution of our pipeline later on.

You can now access your GitLab instance under `localhost:2080` in your browser and log in with the specified credentials: `default_user/C1sco12345` 

Once you successfully authenticated, you will see an existing project called `Default Resources` in which you will find a folder structure named `Ansible/playbooks` where we will store the files that will make up our device configuration.

Now you have the foundation for the pipeline! In this project repository we will store our files and add a CI file which can be interpreted by GitLab and is the collection of stages and tasks that will make up our pipeline in the end.
Next we will add our configuration template to our repository. Storing it centrally in the repo enables tracking of changes, collaborative work and rollback of commits if needed.
After our playbook is stored, we will create the CI file called `.gitlab-ci.yml`. Here we will describe the procedure of our pipeline. We will start with a basic dummy skeleton.

```
stages:
    - dummy

dummy-job:
    stage: dummy
    script:
        - echo "This pipeline is triggered successfully!"
```
