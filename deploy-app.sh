#!/bin/bash
set -e

REPO=$1
BRANCH=$2
FILE=$3
DEPLOY_TAG=$4

docker pull reloni/$REPO:$BRANCH 2> /dev/null || true
kubectl create namespace $BRANCH 2> /dev/null || true

digest=$(docker inspect --format='{{.RepoDigests}}' reloni/$REPO:$DEPLOY_TAG | sed 's/[][]//g')
prefix="reloni/$REPO@sha256:"
export IMAGE_DIGEST=$(echo ${digest#$prefix} | cut -c 1-63)

cat $FILE | envsubst | kubectl apply -f -
