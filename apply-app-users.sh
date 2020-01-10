#!/bin/bash
set -e

while read p; do
  EMAIL=$(echo $p | awk '{ print($1) }')
  NS=$(echo $p | awk '{ print($2) }')
  ID=$(yc iam user-account get $EMAIL | head -1 | awk '{ print($2) }')
  cat ./apps/ns-role-binding.yaml \
    | sed 's/$NAMESPACE/'"$NS"'/' \
    | sed 's/$USER_ID/'"$ID"'/' \
    | kubectl apply -f - || false
done <./apps/app-users.txt
