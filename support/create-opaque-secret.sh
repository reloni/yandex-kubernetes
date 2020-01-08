#!/bin/bash

#example
#sh create-opaque-secret.sh <key_name> <namespace> <key_name> <key_value>

set -e

NAME=$1
NS=$2
KEY=$3
VALUE=$4

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: $NAME
  namespace: $NS
type: Opaque
stringData:
  $KEY: $VALUE
EOF
