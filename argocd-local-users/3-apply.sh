#!/bin/bash
CONFIG_MAP="argocd-cm"

if [ ! -f "${CONFIG_MAP}.yml" ]; then
    echo "Error: First execute ./1-get-current-config.sh"
    exit 1
fi

kubectl apply -f ${CONFIG_MAP}.yml -n argocd
