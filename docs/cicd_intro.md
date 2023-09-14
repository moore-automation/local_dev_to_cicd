# Introduction to CI/CD
CI/CD, shorthand for **Continous Integration/Continous Delivery**, is a practice used in software engineering to deploy a software. Before CI/CD most software was developed and then released in long cycles. A software engineer would develop a feature, throw it over a wall for QA to check that it meets all quality criteria and then, months or sometimes *years* later, the feature would be pushed to the public. This is not the case anymore. Companies like amazon push new code to their systems (production and testing) more then once a second and even seemingly stall pages like google update multiple times every time. 

**Continuous Integration** or CI is the process of continuously integrating new changes/components of the source code into the application. Instead of having one big “push day” where changes are merged we continuously add changes as they are made available by the development team.

Continuous Integration Pipelines usually start with a Source Code Management (SCM) change. New code has been pushed by a developer. What happens next depends on the organization but some common steps are

  1. Clone the code
  2. Compile the code (if needed)
  3. Test the code - This can include running unit, integration and static tests as well as testing for code coverage(what percentage of source code is actually tested by test cases) or memory leak tests.
  4. Report - Either via a dashboard, e-mail, chat or other means of communication
  5. (Deploy) - Code could be automatically deployed into production or staging environments - this last part then makes it a **Continous Delivery** (CD) process.

In this workshop we are going to have a look at such a CI/CD pipeline from the ground up. But in order to continously deliver code we first need *code*.
