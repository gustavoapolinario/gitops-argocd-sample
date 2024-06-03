# About

Appication Sets generate the Application Projects.

It is usefull to load multiple projects dynamically in a single scripts with *.

The project my-apps.yml creates application for all application on folder my-apps/ of this git.

# How to

## Create
```bash
argocd appset create application-sets/argocd-example-apps.yml --port-forward --port-forward-namespace argocd
```

## Delete
```bash
argocd appset delete my-apps --port-forward --port-forward-namespace argocd
```

## List
```bash
argocd appset list --port-forward --port-forward-namespace argocd
```
