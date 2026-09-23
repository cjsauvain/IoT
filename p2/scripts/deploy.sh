#!/bin/bash

set -xe

# Deployments
kubectl apply -f confs/app1/deployment.yaml
kubectl apply -f confs/app2/deployment.yaml
kubectl apply -f confs/app3/deployment.yaml

# Services
kubectl apply -f confs/app1/service.yaml
kubectl apply -f confs/app2/service.yaml
kubectl apply -f confs/app3/service.yaml

# Ingress
kubectl apply -f confs/ingress.yaml
