

## ⛏️ Prequisites<a name = "prequisites"></a>

The pre-requisites are relatively low as the containers install necessary components, you just need to be able to spin up these containers which currently require the below:

- python 3.18
- docker - 4.1.0+
- docker-compose - 1.25.0


<br>

## 🚀How to run <a name = "run"></a>

- Clone the repo

```Shell
git clone https://wwwin-github.cisco.com/Cross-Arch-Automation/Automation-in-a-box.git
```

```Shell

```
- Setting up environment

We are using an environment file to define most of the 'standard' install configurables it's located in root folder '.env' . You can execute the docker-compose without editing anything but it may be useful to alter some of these defaults such as user/pass combo's etc..

- Apple Silicon

If you're running a macbook with apple silicon i've included an ARM based image which offers better performance than the standard gitlab image. You can alter this in the .env file by commenting/uncommenting the EXT_IMAGE_VERSION_GITLAB variable, ARM Image: 'yrzr/gitlab-ce-arm64v8'.


## 🐧 How do I work with this?

This is hopefully fairly straightforward with the below but to clarify:

- If you're looking to use native capabilities for labs/demo just run 'docker-compose up -d' in the root directory 
- If you want to extend functionality the general rule is to create a folder (unless a similar one already exists) with your build artefacts
  - Example #1 - New Ansible playbooks to add policy rules to ASA: Add a folder in content/Ansible folder and then rebuild the images
  - Example #2 - You built a Prometheus instance to pull telemetry data from IOS-XR: Add a build folder called Telemetry_IOS_XR, create a new compose file or add to docker-compose, and a contents folder contianing runtime configs.

```markdown
.
├── build -- *Contains build files for devtools/gitlab inc job details.*
│   ├── devtools
│   ├── gitlab_runner
│   └── gitlab
|
├── content
│   ├── Ansible  -- *Ansible content*
│   │   └── DNAC
│   └── PyATS  -- *PyATS content*
│       └── ACI
├── docs  -- *documentation for github page*
└── docker-compose.yml *simple docker compose for builds*
```
