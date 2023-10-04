# Hands on 2: Linting & Stages

## Linting

As discussed in the main room - linting is a term used to describe tools which make sure we haven't made some serious *tyypos* in our code/configuration. Depending on the tool used there are additional useful features to ensure adherence to a paticular standard as an example most IDEs include PyFlakes which looks for syntactical errors and some recommendations based on agreed standards. You can enahnce this functionality with tools such as [Flake8](https://flake8.pycqa.org/en/latest/index.html#quickstart) which acts as a wrapper for specifications (in this case [PEP8](https://peps.python.org/pep-0008/) which aims to improve readability of code.

For some of us linting might sound like an optional step but in reality ensuring readability and simplicity is essentiall when adopting new technologies or approaches. So do it!! :)

In this task we're going to incorporate a job to lint our Ansible folder to make sure we've no typos!

```yml
yamllint:
  stage: validate
  image: registry.gitlab.com/pipeline-components/yamllint:latest
  script:
    - yamllint Ansible
```

This is a pretty simple example where we're executing a single bash command, we used the `yamllint` image to build a container which linted our Ansible folder and returned success/failure. The exit code is important here as we'll be using it as a conditional step in a future task. To make things really clear i've documented them below:

```yml
Job name:                           yamllint:
Stage name:                           stage: validate
Image name:                           image: registry.gitlab.com/pipeline-components/yamllint:latest
Action:                               script:
CLI execution:                          - yamllint Ansible
```

In production pipelines you should expect to see multiple lint stages depending on the specific tool/language used. In our demo example we could have used both `yamllint` and `ansible-lint` which contain different rule packages though we chose to use one for simplicity.

### Task

The first step of this task is pretty simple:

1. Copy the below into your gitlab ci file, commit the file.

```yml
yamllint:
  image: registry.gitlab.com/pipeline-components/yamllint:latest
  script:
    - yamllint Ansible
```

2. Check to see what happened in the pipeline (CI/CD > Pipelines)
3. Add some junk data to the top of the `interfaces_update.yml` file and hopefully the yamllint job failed.
4. Remove your junk data and check to see success.

That's it for now, but we'll be using the fail/success outcomes in future tasks.

## Stages

Stages are a relatively simple concept in that they contain multiple jobs and represent a logical phase in our workflow, common examples include build, validate, test, deploy etc.. They're useful for isolating functionality and can be used to restrict execution based on a previous phase (as we will see later.) A common use case is don't deploy unless all your tests and build phases have passed.

If no stages are specified, a 'test' stage is implied; so that we can start segmenting our Pipeline we'll create two stages (validate, deploy) at the top of our ci file.

```yml
---
stages:
  - validate
  - deploy
```

For both our jobs `yamllint` and `deploy_dev` you need to specify with which stage the job is associated as below:

```yml
yamllint:
  ...
  stage: validate
  ...

deploy_dev:
  ...
  stage: deploy
  ...
```

Specific devices

only





<details><summary>Click here to show solution</summary>

```yml linenums="1" title="Deploy to Development Final Example"
deploy_dev:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=development' playbooks/interface_update.yml
  only:
    - master
```

</details>



## Conditional Phases





<details><summary>Click here to show solution</summary>

```yml linenums="1" title="Deploy to Development Final Example"
deploy_dev:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=development' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - master
```

</details>