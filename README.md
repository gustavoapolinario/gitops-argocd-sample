# About

This project is a lab to test GitOps with ArgoCD.

You need a local environment first, with it you can install ArgoCD and the ApplicationSet manifests to test the funcionalities of this rep.

With this rep you can:
- configure local users (to test policies)
- configure policies
- create project
- create application
- create application set

# Local Environment

Install a Kubernetes local environment like Minikube

https://minikube.sigs.k8s.io/docs/start/

## Minikube

minikube start

minikube dashboard


# ArgoCD


## Install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/applicationset/master/manifests/install.yaml

## Install argocd CLI

https://argo-cd.readthedocs.io/en/stable/cli_installation/

## Delete
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml

kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/applicationset/master/manifests/install.yaml

## Port-forwarding to use the UI

kubectl port-forward svc/argocd-server -n argocd 8080:443

## Get the admin password

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

## Login on argocd cli

Default login is *admin*

Default admin password is generated. You can get the admin login with the command above.

Now, login the admin credentials:

```bash
argocd login --port-forward  --port-forward-namespace argocd --
```

## Alias

I reccomend make a alias to use argocd without repeatidaly put the parameters "--port-forward  --port-forward-namespace argocd"

```bash
alias argocd="argocd --port-forward --port-forward-namespace argocd"
```

Now, all argocd commands runs these parameters automatically


# Install project

kubectl apply -f argocd-projects/my-project.yaml

# Application

You can apply a ArgoCD Application with:

```bash
kubectl apply -f argocd-example-apps/guestbook.yaml
```

It will generate 1 Application, to improve efficiency, you could use Application Set and install multiple Applications dynamically.

# Application Set

See the doc on [application-sets](./application-sets/README.md)

# Example of applications

The ArgoCD example apps repository have a lot of examples.

You can use manifest directly, you can use helm (inside this git or external), kustomize, etc.

https://github.com/argoproj/argocd-example-apps/tree/master

