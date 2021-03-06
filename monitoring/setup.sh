#!/bin/bash
set -e

kubectl apply -f ns-sa.yaml
kubectl apply -f rbac.yaml
kubectl apply -f config-map.yaml
kubectl apply -f prometheus.yaml
kubectl apply -f kube-state-metrics.yaml
kubectl apply -f grafana.yaml
kubectl apply -f certificate.yaml
kubectl apply -f ingress.yaml
