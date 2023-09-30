# AIR PROJECT
2 Major Goals
1. Development
2. Devops
## Introduction of Project
To build a Frontend and Backend which is able to communicate with each other and run them in some of container technology. 
Build a CICD pipeline that will allow continuous intergration and delivery
## Scope
1. Frontend
2. Backend 
3. CICD
4. Infrastructure
### Implementation Details
1. Frontend 
Using <js>React.js</js> as a framework to build a frontend that allow for interaction to the backend.
Running on default port 3000
Containerized using Dockerfile in repo
2. Backend
Using python flask to quickly deployment a backend service 
Running on default port 5000
Containerized using Dockerfile in repo
3. CICD
- Use helm to deploy GOCD on Kubernetes
- Configure GO Elastic agent (go-agent) kubernetes serviceaccount to have the rights to access all clusters (use conf/install manifests)
- Attached Container Variables such as Docker password etc to go-agent
- Setup gocd-config repo to store GOCD pipeline as code
- Create GOCD pipeline as code and code accordingly
- Create build scripts and deployment scripts
- Build artifacts would be sent to Dockerhub as the artifact storage
- Pull from dockerhub and apply image:version to manifest 
- Create Kubernetes Manifest and deploy to kubernetes cluster
4. Infrastructure
Using KIND as the local machine (WSL2) kubernetes cluster

# Challenges faced
## Development
### Frontend
I have not worked with React as much and to make a more finished product would take me more time and guidance
## Devops
### Install Kubectl on go-agent
Kubectl does not come native with go-agent. therefore I would need to add it somehow.
There are a few options
1. Bake the kubectl into the gocd-agent itself (using Dockerfile)
    Pros: Cleanest method, can be use to add other custom commands if needed
    Cons: The image building requires an open-source agent
    Issue: I tried using the gocd-agent-kind:v23.3.0 as a builder but the curl and install method does not seem to take effect
2. Use apk install (gocd-agent runs on an alpine linux machine)
   Issue: apk and other package management have been removed in gocd-agent
3. Use curl to get the binaries and add it to PATH for usage
   it was the option that worked
### GO-AGENT access to cluster
Default go-agent serviceaccounts does not give much access within the cluster
### Secret Management
My local build and deployment is not perfect when it comes to storage and application of secrets. Such as docker password, git password and serviceaccount access.

# Room for improvment
## Development
The frontend and the backend is far from complete
1. Adding unit test codes for completion, regression and good practice
## Devops
The CICD can be improved by 
1. Adding a TEST stage
2. Include a PERFORMANCE stage for Rate Limit and CPU, MEMORY baselines
3. Infrastructure may include exposure of Frontend to the internet using Cloudflare or other provides as the DNS, CDN and TLS certificate authority provider