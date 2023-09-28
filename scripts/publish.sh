#!/bin/bash -xe
# docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
# docker images
# TAG_NAME=$(git rev-parse --short=8 HEAD)
# docker push $DOCKER_REPO:backend-$TAG_NAME
apk update && \
apk add --no-cache curl && \
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
chmod +x kubectl && \
mv kubectl /usr/local/bin/

kubectl get pod -n gocd