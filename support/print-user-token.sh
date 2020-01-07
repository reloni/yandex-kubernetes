#!/bin/bash
set -e

USER=$1
NS=$2

kubectl -n $NS get secret $(kubectl -n $NS get secret | grep $USER | awk '{print $1}') -o json | \
    jq -r .data.token | \
    base64 --d | sed 's/%//'
