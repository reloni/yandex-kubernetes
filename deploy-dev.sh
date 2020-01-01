#!/bin/bash
set -e

echo "Deploy gotest"
sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml

echo "Deploy redis"
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml

echo "Update ingress"
cat ./apps/ingress-dev.yaml | envsubst | kubectl apply -f -
