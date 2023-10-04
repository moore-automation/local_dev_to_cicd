
# Development vs Production & Testing

Many customers are stuck assessing which areas to prioritise when beginning to automate - a common practice is to prioritise the areas which you most frequently perform. Testing is a great starting point as when we use tools such as `robot framework`, we can abstract the complexities of specific device implementations with abstracted test suites. To give you an example, L3 Routing is an inherently complex area to test; it requires understanding of the existing and desired state, and involves many components with different interfaces (Cisco, Juniper, Arista etc.. ) Before tackling some of these monster jobs, it's usually a good idea to focus on simple and repeatable tasks. For our demo we chose a simple description change and test to demonstrate intent - you could also choose validating attributes like uptime, software version or interface errors to demonstrate to other stakeholders why automating these manual tasks is a great idea!

Like L3 Routing this topic is also a monster but feel free to speak with your proctors who i

Similar to the previous linting phase we're going to add a job to execute our pyATS test from Section 1 - again in practice you're going to see many different types of testing in your pipelines.


## Specific devices

In our lab we're using two switches `cat9kv01-dev` and `cat9kv02-prod` as symbolic representations of development and production - depending on scale you may create seperate stages for these groups; as we're demonstrating concepts we'll keep things simple. To ensure that any serious issues don't affect production, we're going to seperate the execution of the ansible playbook to first target only the development hosts, execute a test and based on the success of the test execute in production.

1. Replace the deploy stage with two covering `development` and `production.` 
2. Rename deploy_infra to deploy_dev, assigned to correct stage and update the environment variable within the ansible-playbook command to run only on dev devices (check Ansible Inventory file in case you get stuck)

<details><summary>Click here to show solution</summary>

```yml linenums="1"
deploy_dev:
  stage: development
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=development' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - master

```

</details>

3. Create a production job called `deploy_prod` assigned to correct stage, which targets only production devices.

<details><summary>Click here to show solution</summary>

```yml linenums="1"

deploy_prod:
  stage: production
  script:
    - cd Ansible
    - ansible-playbook -i inventory -e 'devices=production' playbooks/interface_update.yml
  needs: 
    - yamllint
  only:
    - master    
```

</details>

## Task - Adding a test job

You should be a whizz at creating jobs in ci files by now so we've included them below, when you choose to edit the `.gitlab-ci.yml` file you are given an option to edit in 'Pipeline Editor' which allows you to visualize the change. 

1. Add a stage for test.
2. Create two jobs `test_dev` and `test_prod` , update the pyATS command as appropriate.
3. Update `needs:` on both deploy jobs as appropriate to ensure tests follow deploy actions and production deploy doesn't execute until test_dev has completed.
4. Experiment with these features to make sure your change creates the new stage and job.

* pyATS synax : `python3 pyATS_test.py dev 1 ` = development switch, interface 1.

```yml linenums="1" title="pyATS example"

test_XXX:
  stage: XXX
  script:
    - cd pyATS
    - 'Insert pyATS commands'
  needs:
    - XXXX

```

**NOTE:** update your interface to the one which your proctor provides for Section 2 *

The complete CI file can be found here: [Complete CI File](https://github.com/moore-automation/local_dev_to_cicd/blob/main/content/gitlab/.gitlab-ci.yml)

## Gold Star Exercises

* Docs as Code: Check out of Github Actions file and try and figure out how we've made this lab guide!