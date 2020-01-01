#!/bin/bash
set -e

docker pull reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null || true

if [[ "$(docker images -q reloni/goexample:$CI_COMMIT_REF_NAME 2> /dev/null)" == "" ]]; then
  TAG=latest
else
  TAG=$CI_COMMIT_REF_NAME
fi

TAG=latest

cat <<EOF > gotest-deployment.yaml
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
      - image: reloni/goexample:latest
        name: gotest-app
        ports:
        - containerPort: 8080
          protocol: TCP
EOF

kubectl apply -f gotest-deployment.yaml
rm gotest-deployment.yaml
