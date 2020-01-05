#!/bin/bash
set -e

sh create-self-signed-cert.sh nginx-ingress-default nginx-ingress "example.com" "Default"

sh create-self-signed-cert.sh ad-rocks-widlcard rick "*.alpinadigital.rocks" "AD Rocks Wildcard"
sh create-self-signed-cert.sh ad-rocks-widlcard morty "*.alpinadigital.rocks" "AD Rocks Wildcard"

sh create-self-signed-cert.sh ad-rocks-static-rick rick "static.rick.alpinadigital.rocks" "AD Rocks Static Rick"
sh create-self-signed-cert.sh ad-rocks-static-morty morty "static.morty.alpinadigital.rocks" "AD Rocks Static Morty"
