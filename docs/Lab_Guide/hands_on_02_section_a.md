# Hands on 2: Linting & Stages

## Linting

As discussed in the main room - linting is a term used to describe tools which make sure we haven't made some serious *tyypos* in our code/configuration. Depending on the tool used there are additional useful features to ensure adherence to a particular standard as an example most IDEs include PyFlakes which looks for syntactical errors and some recommendations based on agreed standards. You can enhance this functionality with tools such as [Flake8](https://flake8.pycqa.org/en/latest/index.html#quickstart) which acts as a wrapper for specifications (in this case [PEP8](https://peps.python.org/pep-0008/) which aims to improve readability of code.

For some of us linting might sound like an optional step but in reality ensuring readability and simplicity is essentially when adopting new technologies or approaches. So do it!! :)

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
Job name: -> yamllint:
Stage name: ->  stage: validate
Image name: -> image: registry.gitlab.com/pipeline-components/yamllint:latest
Action: ->  script:
CLI execution:  ->  - yamllint Ansible
```

In production pipelines you should expect to see multiple lint stages depending on the specific tool/language used. In our demo example we could have used both `yamllint` and `ansible-lint` which contain different rule packages though we chose to use one for simplicity.

### Task - Add lint job

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

We tested before the outcome of linting above, so now we'll test an 
For both our jobs `yamllint` and `deploy_infra` you need to specify with which stage the job is associated as below:

```yml
yamllint:
  ...
  stage: validate
  ...

deploy_infra:
  ...
  stage: deploy
  ...
```

### Task - Add Stages

1. Update your ci file with stages as above
2. Inspect the Pipeline to see separation of jobs.

## Conditional Phases

There are many ways to create logic between jobs within Gitlab CI/CD, the simplest uses the `needs:` parameter to specify that the execution of a job relies on the successful execution of a previous job. In our case we want to ensure that the deploy_infra job doesn't execute until the lint job has successfully completed.

### Task - Conditional Execution

1. Specify that deploy_infra requires yamllint to execute before it can begin.

<details><summary>Click here to show solution</summary>

```yml linenums="1" title="Conditional Execution"
deploy_infra:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=all' playbooks/interface_update.yml
  needs: 
    - yamllint    
```

</details>

## Branch Specific Policies

As a project expands it in nearly all cases becomes necessary to create branches when working across diverse teams or infrastructure - making changes directly to master is in fact considered bad practice as it increases complexity when resolving `merge conflicts` and approving `pull requests.` Typically we would recommend creating function specific branches to avoid these issues.

In most production instances would will see increased restrictions around branches that are permitted to make changes to 'protected' resources - a simple example is that you can only make changes to production from the master or 'prod' branch, and you can only push changes to that branch after review from your peers.

In our example we're going to use the `only:` parameter to ensure that only changes from master can execute this job.

### Task - Branch policy

1. Similar to the needs parameter, update deploy_infra to only execute from the master branch.

<details><summary>Click here to show solution</summary>

```yml linenums="1" title="Conditional Execution"
deploy_infra:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=all' playbooks/interface_update.yml
  needs: 
    - yamllint    
  only:
    - master
```

</details>

## Conclusion

Great job for getting this far, I hope you'll takeaway the idea that testing the quality of our changes in advance is a good thing and adding enhancements like linting and conditional changes is a simple process with great rewards! Please move on to the next section in the navigation bar on the left.
