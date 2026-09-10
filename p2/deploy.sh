#!/bin/bash

set -xe

# Deployments
kubectl apply -f app1/deployment.yaml
kubectl apply -f app2/deployment.yaml
kubectl apply -f app3/deployment.yaml

# Services
kubectl apply -f app1/service.yaml
kubectl apply -f app2/service.yaml
kubectl apply -f app3/service.yaml

# Ingress
kubectl apply -f ingress.yaml
