#!/bin/bash
CONFIG_MAP="argocd-cm"

kubectl get configmap ${CONFIG_MAP} -n argocd -o yaml > ${CONFIG_MAP}.yml

# Create a backup of current file
CURR_DATETIME=$(date +"%Y-%m-%d-%H-%M")
cp ${CONFIG_MAP}.yml ${CONFIG_MAP}_bkp-$CURR_DATETIME.yml
