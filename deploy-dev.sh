#!/bin/bash
set -e

cat ./apps/memory-defaults.yaml | envsubst | kubectl apply --namespace=$CI_COMMIT_REF_NAME -f -

echo "Deploy gotest"
sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml

echo "Deploy redis"
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml

echo "Update ingress"
kubectl delete ingress --all --namespace=$CI_COMMIT_REF_NAME

NAMESPACE="$CI_COMMIT_REF_NAME" \
  envsubst '$NAMESPACE' < ./apps/ingress-dev.yaml \
  | kubectl apply -f -
cat ./nginx-ingress-controller/nginx-config.yaml | kubectl apply -f -
