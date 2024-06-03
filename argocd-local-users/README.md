# About

The RBAC is a Role Based Access Controller. The scripts will create local users to test the RBAC policies inside ArgoCD.

This project create local users to give permission to understand the policies.

## How it works

This folder has 3 scripts:

1-get-current-config.sh

2-add-user-to-manifest.sh

3-apply.sh

The first get the current config and save to a file argocd-cm.yml

execute:
```bash
./1-get-current-config.sh
```

On the second script, the current config will be merged with another manifest to generate

execute:
```bash
./2-add-user-to-manifest.sh admin-user.yaml
./2-add-user-to-manifest.sh read-user.yaml
./2-add-user-to-manifest.sh sync-user.yaml
```

For last, with the config merged, the third script will apply the configuration on argoCD

execute:
```bash
./3-apply.sh
```

# Change a user password

## Login on argocd cli


Default login is *admin*
Default admin password is generated. You can get by the command:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Now, login the admin credentials:

```bash
argocd login --port-forward  --port-forward-namespace argocd --
```

## Set/Change the user password

To change password, you need to the below command.

You need specify the user who will be changed the password and the new password for this user.

The command needs your current password too. The password of the same user logged, in other words, the password used on argocd login command.

```bash
argocd account update-password --account USER_NAME --new-password NEW_USER_PASSWORD --current-password ARGOCD_ADMIN_LOGGED_PASSWORD --port-forward --port-forward-namespace argocd
```

to facilitate the understanting, this is the same script, but with variables:

```bash
ARGOCD_ADMIN_LOGGED_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)

USER_NAME="adminuser"
NEW_USER_PASSWORD="new-adminuser-password"

argocd account update-password --account $USER_NAME --new-password $NEW_USER_PASSWORD --current-password $ARGOCD_ADMIN_LOGGED_PASSWORD --port-forward --port-forward-namespace argocd
```
