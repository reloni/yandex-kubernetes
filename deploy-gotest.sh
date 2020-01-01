#!/bin/bash
set -e

docker pull reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null || true

if ["$(docker images -q reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null)" == ""]; then
  export GOTEST_TAG=latest
else
  export GOTEST_TAG=$CI_COMMIT_REF_NAME
fi

cat gotest-app.yaml | envsubst | kubectl apply -f -
