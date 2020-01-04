#!/bin/bash
set -e

kubectl create ns $CI_COMMIT_REF_NAME || true
cat ./apps/memory-defaults.yaml | envsubst | kubectl apply --namespace=$CI_COMMIT_REF_NAME -f -

echo '\033[0;32mDeploy gotest\033[0m'
sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy static\033[0m'
sh deploy-app.sh go-static-files $CI_COMMIT_REF_NAME ./apps/go-static-files.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy redis\033[0m'
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mUpdate ingress\033[0m'
kubectl delete ingress --all --namespace=$CI_COMMIT_REF_NAME

NAMESPACE="$CI_COMMIT_REF_NAME" \
  envsubst '$NAMESPACE' < ./apps/ingress-dev.yaml \
  | kubectl apply -f -
cat ./nginx-ingress-controller/nginx-config.yaml | kubectl apply -f -
