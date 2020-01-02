#!/bin/bash
set -e

kubectl apply -f ns-and-sa.yaml
kubectl apply -f nginx-config.yaml
kubectl apply -f custom-resource-definitions.yaml
kubectl apply -f rbac.yaml
kubectl apply -f load-balancer.yaml
kubectl apply -f nginx-ingress.yaml

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=example.com"

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
  namespace: nginx-ingress
type: Opaque
data:
  tls.crt: $(cat tls.crt | base64)
  tls.key: $(cat tls.key | base64)
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: default-server-secret
  namespace: nginx-ingress
type: Opaque
data:
  tls.crt: $(cat tls.crt | base64)
  tls.key: $(cat tls.key | base64)
EOF

rm tls.key
rm tls.crt

3641  kubectl exec -it -n nginx-ingress nginx-ingress-fqqd9 cat /etc/nginx/conf.d/morty-morty-ingress.conf
3642  kubectl exec -it -n nginx-ingress nginx-ingress-fqqd9 cat /etc/nginx/nginx.conf
