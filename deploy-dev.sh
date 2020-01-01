#!/bin/bash
set -e

sh deploy-app.sh ./apps/goexample $CI_COMMIT_REF_NAME ./gotest-app.yaml
sh deploy-app.sh ./apps/goexample-redis $CI_COMMIT_REF_NAME ./gotest-redis.yaml
cat ./apps/ingress-dev.yaml | envsubst | kubectl apply -f -
