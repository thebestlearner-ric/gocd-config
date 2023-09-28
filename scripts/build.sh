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

DOCKER_REPO=learningric/air_artifact
docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
TAG_NAME=$(git rev-parse --short=8 HEAD)
docker push $DOCKER_REPO:backend-TAG_NAME
