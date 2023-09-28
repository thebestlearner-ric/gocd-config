#!/bin/bash -xe
docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
TAG_NAME=$(git rev-parse --short=8 HEAD)
docker push $DOCKER_REPO:backend-$TAG_NAME