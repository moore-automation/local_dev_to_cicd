
# Agenda

## Section 1: Introduce Concepts - 20 minutes

    -  Typical Use Cases/Personas
    -  Lab Topology - basic setup/connectivity
    -  CICD 
        -  Why we need it
        -  What it does and how it helps
    -  IaC 
        -  CLI Migration - CLI to tools/processes and job retention
        -  Config formats - specific syntax to generic data and templates
        -  Standardised processes - governance, triggers

### Demo - 30 minutes

    -  Device 
        -  Example on doing per hand
        -  Example of doing using a tool
    -  Gitlab 
        -  Create project
        -  Add files to project
        -  Create CI file
        -  Test commit

## Section 2: Dev vs Prod, Pipeline validation - 10 minutes

    -  ‘Advanced’ Pipeline Stages 
        -  Blocks : Validation, Dev deploy, testing, prod deploy
    -  Validation 
        -  Syntax/Linting
        -  Unit/smoke
        -  Functional/UAT

### Project Examples - 30 minutes

    -  Device 
        -  Example using gitlab commit trigger
    -  Gitlab 
        -  Update CI to include change to dev environment first
    -  Validation 
        -  Add linter for validation
        -  PyATS check device state

### Closure/Summary - 10 minutes

    -  Overview of concepts
    -  Example of use cases
    -  Review of different approaches (CLI, simple tools, simple pipelines, advanced pipelines)
    -  Next Steps
