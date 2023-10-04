
# Development vs Production & Testing

Many customers are stuck assessing which areas to prioritise when beginning to automate - a common practice is to prioritise the areas which you most frequently perform. Testing is a great starting point as when we use tools such as `robot framework`, we can abstract the complexities of specific device implementations with abstracted test suites. To give you an example, L3 Routing is an inherently complex area to test; it requires understanding of the existing and desired state, and involves many components with different interfaces (Cisco, Juniper, Arista etc.. ) Before tackling some of these monster jobs, it's usually a good idea to focus on simple and repeatable tasks. For our demo we chose a simple description change and test to demonstrate intent - you could also choose validating attributes like uptime, software version or interface errors to demonstrate to other stakeholders why automating these manual tasks is a great idea!

Like L3 Routing this topic is also a monster but feel free to speak with your proctors who i

Similar to the previous linting phase we're going to add a job to execute our pyATS test from Section 1 - again in practice you're going to see many different types of testing in your pipelines.

## Task - Adding a test job

You should be a whizz at creating jobs in ci files by now so we've included them below, when you choose to edit the `.gitlab-ci.yml` file you are given an option to edit in 'Pipeline Editor' which allows you to visualize the change. Experiment with these features to make sure your change creates the new stage and job.

* NOTE: update your interface to the one which your proctor provides for Section 2 *

```yml linenums="1" title="pyATS example"

test_infra:
  stage: testing
  script:
    - cd pyATS
    - echo 'Insert pyATS commands'
  needs:
    - deploy_infra

```

## Specific devices

In our lab we're using two switches `cat9kv01-dev` and `cat9kv02-prod` as symbolic representations of development and production - depending on scale you may create seperate stages for these groups; as we're demonstrating concepts we'll keep things simple. To ensure that any serious issues don't affect production, we're going to seperate the execution of the ansible playbook to first target only the development hosts, execute a test and based on the success of the test execute in production.

1. Rename deploy_infra to deploy_dev and update the environment variable within the ansible-playbook command to run only on dev devices (check Ansible Inventory file in case you get stuck)

<details><summary>Click here to show solution</summary>

```yml linenums="1"
deploy_dev:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=development' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - main

```

</details>

2. Create a production job called `deploy_prod` which targets only production devices.

<details><summary>Click here to show solution</summary>

```yml linenums="1"

deploy_prod:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=production' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - main    
```

3. Update deploy_prod so that it depends on the execution of the pyATS test.

<details><summary>Click here to show solution</summary>

```yml linenums="1" title="Deploy to Development Final Example"

deploy_prod:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=production' playbooks/interface_update.yml
  needs: 
    - test_infra
  only:
    - main    
```

</details>

</details>


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
    - main

deploy_prod:
  stage: deploy
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=production' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - main    
```

</details>


## Gold Star Exercises

* Docs as Code: Check out of Github Actions file and try and figure out how we've made this lab guide!