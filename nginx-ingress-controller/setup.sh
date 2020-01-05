#!/bin/bash
set -e

kubectl apply -f ns-and-sa.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f custom-resource-definitions.yaml
kubectl apply -f rbac.yaml
kubectl apply -f load-balancer.yaml
kubectl apply -f nginx-ingress.yaml
