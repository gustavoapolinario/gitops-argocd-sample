#!/bin/bash
CONFIG_MAP="argocd-cm"

if [ ! -f "${CONFIG_MAP}.yml" ]; then
    echo "Error: First execute the 1-get-current-config.sh"
    exit 1
fi

# Check if exactly one parameter is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Need the name of the file to with user information."
    echo "ex:"
    echo "$0 admin-user.yaml"
    echo "$0 read-user.yaml"
    echo "$0 sync-user.yaml"
    exit 1
fi

yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq "$@"
}
yq eval-all '. as $item ireduce ({}; . * $item)' ${CONFIG_MAP}.yml $1 | tee merged.yml

mv merged.yml ${CONFIG_MAP}.yml
