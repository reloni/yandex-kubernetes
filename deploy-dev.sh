#!/bin/bash
set -e

sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./gotest-app.yaml
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./gotest-redis.yaml
cat ingress-dev.yaml | envsubst | kubectl apply -f -
