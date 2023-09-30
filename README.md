# gocd-config
## Install Kubectl
Kubectl does not come native with gocd-agent. therefore I would need to add it somehow.
There are a few options
1. Bake the kubectl into the gocd-agent itself (using Dockerfile)
    Pros: Cleanest method, can be use to add other custom commands if needed
    Cons: The image building requires an open-source agent
    Issue: I tried using the gocd-agent-kind:v23.3.0 as a builder but the curl and install method does not seem to take effect
2. Use apk install (gocd-agent runs on an alpine linux machine)
   Issue: apk and other package management have been removed in gocd-agent
3. Use curl to get the binaries and add it to PATH for usage
   it was the option that worked
