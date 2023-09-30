#!/bin/bash -xe
#
# Example script to be used on a Go agent that build using Docker:
#
# - create a Docker image to be used for production running
# - copy the artifacts from the build into this container
# - push it to a registry
#
# AWS_ECR_LOCATION needs to exist an an env variable

# This will be the name of the resulting Docker image
# This values could come from the GoCD environment
ENV=$1
cd ../air-$ENV-repo
DOCKER_REPO=learningric/air_artifact
TAG_NAME=$(git rev-parse --short=8 HEAD)
IMAGE="$DOCKER_REPO:$ENV"_"$TAG_NAME"
docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
docker build -t $IMAGE .
docker push $IMAGE
docker pull $IMAGE
docker images