#!/bin/bash
set -e

REPO=$1
BRANCH=$2
FILE=$3

docker pull reloni/$REPO:$BRANCH 2> /dev/null || true
kubectl create namespace $BRANCH 2> /dev/null || true

if ["$(docker images -q reloni/$REPO:$BRANCH 2> /dev/null)" == ""]; then
  export DEPLOY_TAG=latest
else
  export DEPLOY_TAG=$BRANCH
fi

digest=$(docker inspect --format='{{.RepoDigests}}' reloni/$REPO:$DEPLOY_TAG | sed 's/[][]//g')
prefix="reloni/$REPO@sha256:"
export IMAGE_DIGEST=${digest#$prefix} | cut -c 1-63

cat $FILE | envsubst | kubectl apply -f -
