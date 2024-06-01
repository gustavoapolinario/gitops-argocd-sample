#!/bin/bash
CONFIG_MAP="argocd-rbac-cm"

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
yq eval-all '
  select(fileIndex == 0) as $base |
  select(fileIndex == 1) as $new |
  $base.data."policy.csv" += "\n" + $new.data."policy.csv" |
  $base.data."policy.csv" style="literal" |
  . as $item ireduce ({}; . * $item) |
  .data."policy.csv" = $base.data."policy.csv"' ${CONFIG_MAP}.yml $1 | tee merged.yml

mv merged.yml ${CONFIG_MAP}.yml
