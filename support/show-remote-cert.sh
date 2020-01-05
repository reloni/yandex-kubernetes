#!/bin/bash
HOST=$1
echo | openssl s_client -showcerts -servername $HOST -connect $HOST:443 2>/dev/null | openssl x509 -inform pem -noout -text
