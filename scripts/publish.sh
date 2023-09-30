#!/bin/bash -xe

# For Kubectl deployment
alias k="$HOME/.local/bin/kubectl"
k get pod -n gocd

NAMESPACE="$ENV"
git clone https://github.com/thebestlearner-ric/air-backend.git
git rev-parse --short HEAD
docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
docker images
if k get namespace "$NAMESPACE" &> /dev/null; then
  echo "Namespace '$NAMESPACE' already exists."
else
  echo "Namespace '$NAMESPACE' does not exist. Creating..."
  k create namespace "$NAMESPACE"
  echo "Namespace '$NAMESPACE' created."
fi

