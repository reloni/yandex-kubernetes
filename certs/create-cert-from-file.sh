#!/bin/bash

kubectl create secret tls nginx-ingress-default --key privkey.pem --cert fullchain.pem \
  --namespace=nginx-ingress --dry-run -o yaml | kubectl apply -f -
