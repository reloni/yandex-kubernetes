#!/bin/bash
set -e

cat ./apps/memory-defaults.yaml | envsubst | kubectl apply --namespace=$CI_COMMIT_REF_NAME -f -

echo -e '\e[38;5;82mDeploy gotest'
sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml $CI_COMMIT_REF_NAME

echo -e '\e[38;5;82mDeploy static'
sh deploy-app.sh go-static-files $CI_COMMIT_REF_NAME ./apps/go-static-files.yaml $CI_COMMIT_REF_NAME

echo -e '\e[38;5;82mDeploy redis'
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml $CI_COMMIT_REF_NAME

echo -e '\e[38;5;82mUpdate ingress'
kubectl delete ingress --all --namespace=$CI_COMMIT_REF_NAME

NAMESPACE="$CI_COMMIT_REF_NAME" \
  envsubst '$NAMESPACE' < ./apps/ingress-dev.yaml \
  | kubectl apply -f -
cat ./nginx-ingress-controller/nginx-config.yaml | kubectl apply -f -
