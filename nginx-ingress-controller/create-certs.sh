#!/bin/bash
set -e

sh create-self-signed-cert.sh ad-rocks-widlcard nginx-ingress "*.alpinadigital.rocks" "AD Rocks Wildcard"
sh create-self-signed-cert.sh ad-rocks-static-rick nginx-ingress "static.rick.alpinadigital.rocks" "AD Rocks Static Rick"
sh create-self-signed-cert.sh ad-rocks-static-morty nginx-ingress "static.morty.alpinadigital.rocks" "AD Rocks Static Morty"
