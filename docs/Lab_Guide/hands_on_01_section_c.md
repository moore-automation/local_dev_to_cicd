# All hands on GitLab

To get started with GitLab, we will make use of all of the containers that you spun up previously.

You can now access your GitLab instance under `localhost:2080` in your browser and log in with the specified credentials: `default_user/C1sco12345` 

Once you successfully authenticated, you will see an existing project called `Default Resources` in which you will find a folder structure named `Ansible/playbooks` where we will store the files that will make up our device configuration.

Now you have the foundation for the pipeline! In this project repository we will store our files and add a CI file which can be interpreted by GitLab and is the collection of stages and tasks that will make up our pipeline in the end.
Next we will add our configuration template to our repository. Storing it centrally in the repo enables tracking of changes, collaborative work and rollback of commits if needed.
After our playbook is stored, we will create the CI file called `.gitlab-ci.yml`. Here we will describe the procedure of our pipeline. We will start with a basic dummy skeleton.

```yml
  stages:
      - dummy

  dummy-job:
      stage: dummy
      script:
          - echo "This pipeline is triggered successfully!"
```

Once you commit this CI file in the repository, the pipeline will get triggered for the first time. Make sure to check if the pipeline was successful and the command was executed through the runner.

**You will now start to write you own CI file to configure the `dev` Switch using Ansible.**

The Ansible playbooks can be found in the Ansible subdirectory and executed from there. Keep this in mind while building your pipeline.
Playbooks can be excuted through Ansible with the command `ansible-playbook` followed by the `-i` option, specifying the inventory file - which is already prepared for you. For applying additional variables you can use the `-e` option. The `interface_update.yml` playbook resides in the `playbooks` subdirectory. Please have a look at the playbook as well to understand what we want to achieve with it. Maybe you will even find a hint on how to  execute the playbook against only one of the two defined devices.

If you are having trouble with this task, we have prepared and example in the dropdown below.

<details>

<summary>Click here to show solution</summary>
  
  ```bash linenums="1" title="Ansible Pipeline example"
  ---
  stages:
    - deploy_test
  deploy_infra:
    stage: deploy_test
    script:
      - cd Ansible
      - ansible-playbook -i inventory -e 'devices=cat9kv01-dev' playbooks/interface_update.yml
  ```

</details>
