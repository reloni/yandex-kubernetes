#!/bin/bash
set -e

docker pull reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null || true

if [[ "$(docker images -q reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null)" == "" ]]; then
  TAG=latest
else
  TAG=$CI_COMMIT_REF_NAME
fi

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gotest-app
spec:
  replicas: 5
  selector:
    matchLabels:
      app: gotest-app
  template:
    metadata:
          labels:
            app: gotest-app
    spec:
      containers:
      - image: reloni/goexample:$TAG
        name: gotest-app
        ports:
        - containerPort: 8080
          protocol: TCP
EOF
