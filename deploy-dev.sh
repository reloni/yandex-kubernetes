#!/bin/bash
set -e

sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml
cat ./apps/ingress-dev.yaml | envsubst | kubectl apply -f -
