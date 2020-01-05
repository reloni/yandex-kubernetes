#!/bin/bash
set -e

NAME=$1
NAMESPACE=$2
CN=$3
O=$4

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=$CN/O=$O" && \
kubectl create secret tls $NAME --key tls.key --cert tls.crt \
  --namespace=$NAMESPACE --dry-run -o yaml | kubectl apply -f -
rm tls.key
rm tls.crt
