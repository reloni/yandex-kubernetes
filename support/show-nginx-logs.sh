#!/bin/bash
set -e

kubectl logs -n nginx-ingress daemonset/nginx-ingress
