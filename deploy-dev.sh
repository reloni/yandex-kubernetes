#!/bin/bash
set -e

kubectl create ns $CI_COMMIT_REF_NAME || true

echo '\033[0;32mUpdate namespace role\033[0m'
cat ./apps/ns-role.yaml | sed 's/$NAMESPACE/'"$DEPLOY_TAG"'/' | kubectl apply -f -

echo '\033[0;32mUpdate users\033[0m'
sh apply-app-users.sh

echo '\033[0;32mUpdate memory defaults\033[0m'
cat ./apps/memory-defaults.yaml | envsubst | kubectl apply --namespace=$CI_COMMIT_REF_NAME -f -

echo '\033[0;32mUpdate nginx config\033[0m'
cat ./nginx-ingress-controller/nginx-config.yaml | kubectl apply -f -

echo '\033[0;32mDeploy gotest\033[0m'
sh deploy-app.sh goexample $CI_COMMIT_REF_NAME ./apps/gotest-app.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy static\033[0m'
sh deploy-app.sh go-static-files $CI_COMMIT_REF_NAME ./apps/go-static-files.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy redis\033[0m'
sh deploy-app.sh goexample-redis $CI_COMMIT_REF_NAME ./apps/gotest-redis.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy minio\033[0m'
sh deploy-app.sh files-minio $CI_COMMIT_REF_NAME ./apps/files-minio.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy fastcgi\033[0m'
sh deploy-app.sh fastcgi $CI_COMMIT_REF_NAME ./apps/fastcgi.yaml $CI_COMMIT_REF_NAME

echo '\033[0;32mDeploy staticweb\033[0m'
DEPLOY_TAG="$CI_COMMIT_REF_NAME" \
  envsubst '$DEPLOY_TAG' < ./apps/staticweb.yaml \
  | kubectl apply -f -
