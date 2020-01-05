#!/bin/bash
set -e

kubectl apply -f ns-sa.yaml
kubectl apply -f rbac.yaml
kubectl apply -f config-map.yaml
kubectl apply -f prometheus.yaml
kubectl apply -f kube-state-metrics.yaml
