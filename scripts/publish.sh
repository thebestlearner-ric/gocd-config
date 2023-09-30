#!/bin/bash -xe

# For Kubectl deployment
$HOME/.local/bin/kubectl get pod -n gocd
ENV=backend
NAMESPACE=$ENV
cd ../air-backend-repo
TAG="$(git rev-parse --short=8 HEAD)"
cd ../air-backend-repo-config
TAG_NAME="$ENV-$TAG"
docker pull $DOCKER_REPO:$TAG_NAME
docker images

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
IMAGE="$DOCKER_REPO:$TAG_NAME"
echo $IMAGE
sed -i "s/\$IMAGE/$(echo "$IMAGE")/g" kube/manifest/*.yaml
echo "$(cat kube/manifest/backend-deployment.yaml)"
$HOME/.local/bin/kubectl apply -f kube/manifest/backend-deployment.yaml -n $ENV
echo "apply service.yaml"
$HOME/.local/bin/kubectl apply -f kube/manifest/backend-service.yaml -n $ENV