#!/bin/bash
set -e

kubectl exec -it $(kubectl get pods -n nginx-ingress | sed -n 2p | awk '{ print($1) }') -n nginx-ingress cat nginx.conf
