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

IMAGE=${learningric/air_artifact}
COMMIT=${git rev-parse --short=8 HEAD}
TAG=${backend-$COMMIT}

# 1. Build the production container.
docker build -t $IMAGE:$TAG -f ../Dockerfile .

# Tag and push to ECR
docker tag $IMAGE:$TAG 
docker push $IMAGE:$TAG