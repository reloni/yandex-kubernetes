#!/bin/bash
set -e

kubectl apply -f ns-and-sa.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f custom-resource-definitions.yaml
kubectl apply -f rbac.yaml
kubectl apply -f load-balancer.yaml
kubectl apply -f nginx-ingress.yaml

#sh create-cert.sh

3641  kubectl exec -it -n nginx-ingress nginx-ingress-fqqd9 cat /etc/nginx/conf.d/morty-morty-ingress.conf
3642  kubectl exec -it -n nginx-ingress nginx-ingress-fqqd9 cat /etc/nginx/nginx.conf
