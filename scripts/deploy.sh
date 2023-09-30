#!/bin/bash -xe

# For Kubectl deployment
$HOME/.local/bin/kubectl get pod -n gocd
ENV=$1
NAMESPACE=$ENV
cd ../air-$ENV-repo
TAG="$(git rev-parse --short=8 HEAD)"
cd ../air-$ENV-repo-config
TAGNAME="$ENV"_"$TAG"

if $HOME/.local/bin/kubectl get namespace "$NAMESPACE" &> /dev/null; then
  echo "Namespace '$NAMESPACE' already exists."
else
  echo "Namespace '$NAMESPACE' does not exist. Creating..."
  $HOME/.local/bin/kubectl create namespace "$NAMESPACE"
  echo "Namespace '$NAMESPACE' created."
fi

echo "what is in kube manifest $(ls -altr kube/manifest/)"
echo "Deploying..."
echo "apply deployment.yaml"
echo $TAGNAME

if [ "$1" == "frontend" ]; then
    echo "You provided 'frontend' as the parameter."
    echo "You provided 'backend' as the parameter."
    sed -i "s/TAG/$(echo $TAGNAME)/g" kube/manifest/frontend-deployment.yaml
    echo "$(cat kube/manifest/frontend-deployment.yaml)"
    $HOME/.local/bin/kubectl apply -f kube/manifest/frontend-deployment.yaml -n $ENV
    echo "apply service.yaml"
    $HOME/.local/bin/kubectl apply -f kube/manifest/frontend-service.yaml -n $ENV
elif [ "$1" == "backend" ]; then
    echo "You provided 'backend' as the parameter."
    sed -i "s/TAG/$(echo $TAGNAME)/g" kube/manifest/backend-deployment.yaml
    echo "$(cat kube/manifest/backend-deployment.yaml)"
    $HOME/.local/bin/kubectl apply -f kube/manifest/backend-deployment.yaml -n $ENV
    echo "apply service.yaml"
    $HOME/.local/bin/kubectl apply -f kube/manifest/backend-service.yaml -n $ENV
fi