# Hands-On series part 8: From local application to full CI/CD pipeline

Simple project to generate gitlab and a development environment, with intention to demonstrate how to make basic changes using Ansible, Gitlab & PyATS.

## Status

The code and artefacts within this repository are considered in development and should not be used in production without sufficient testing.

## Environment Deployment

A single docker compose file is used to build and run the following components, appropriate volumes and networks are created to ensure consistency when restarting the instance.

- Gitlab Community Edition
- Gitlab Runner 
- 'DevTools' : Ubuntu image with Ansible and PyATS installed

## Getting Started

This project is extremely simple, it requires only docker to be installed on the host and this repository to be cloned or manually copied. *default today is compose version 2*

1. To start the service simply run either of the following:
   1. (Version 1) ```docker-compose up -d```
   2. (Version 2+) ```docker compose up -d```
2. Check containers are spinning up
3. Go have a cup of tea for 5 minutes while gitlab get's ready.
4. Access gitlab in your browser : http://localhost:2080
5. Access devtools from cli : ```docker exec -it engine_devtools bash```
