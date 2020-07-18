# Capstone - Udacity Cloud DevOps Engineering Nanodegree finall project

This is project being part of [Become a Cloud Dev Ops Engineer](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991)

## What was done here: 

- Implemented demo Flask JokesAPI returning random jokes
- Docker image was defined for application (Dockerfile)
- Created AWS EC2 machine and set up Jenkins instance on top of it
- Created CloudFormation scripts and deployed to AWS cloud:
  1. AWS Virtual Private Cloud (VPC) network infrastructure
  2. AWS Elastic Kubernetes Sercice (EKS) cluster
- Attached node groups to EKS to handle cluster workload
- Deployed JokesAPI application to Kubernetes cluster, with rolling update strategy and 4 replicas
- Deployed Elastic Load Balancer to VPC, and attached it to cluster as Kubernetes service to expose application to world 
- Configured Jenkins credentials to allow push to DockerHub images registry
- Configured Jenkins credentials to allow utilize AWS CLI (deploy step)
- Configured Jenkins pipeline for CI/CD consisting of steps:
  1. Linting python web api (Flask) as well Dockerfile 
  2. Building application to docker image and pushing following versions to DockerHub registry
  3. Deploy to AWS Elastic Kubernetes service