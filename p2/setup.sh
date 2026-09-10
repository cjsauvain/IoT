#!/bin/bash

set -xe

# Configure kubectl
vagrant ssh afabyS -c "sudo cat /etc/rancher/k3s/k3s.yaml" 2>/dev/null >$HOME/.kube/config

# Install Ingress Controller (Traefik) using Helm
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install my-ingress traefik/traefik \
  --namespace traefik \
  --create-namespace

# Check that the installation succeded
kubectl get ingressclass
