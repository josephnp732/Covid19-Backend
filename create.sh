#!/usr/bin/env bash

# Terraform

terraform init &&
terraform plan &&
terraform apply --auto-approve &&

# Kubectl Setup
terraform output config_map_aws_auth > config_map_aws_auth.yaml &&
terraform output kubeconfig > ~/.kube/config-terraform-eks-covid19 &&
export KUBECONFIG=~/.kube/config-terraform-eks-covid19:~/.kube/config &&
echo "export KUBECONFIG=${KUBECONFIG}" >>${HOME}/.bash_profile &&
kubectl apply -f config_map_aws_auth.yaml &&


# Apply Deployments
kubectl apply -f ./deployments/deployment-all.yaml &&
kubectl apply -f ./deployments/deployment-countries.yaml &&
kubectl apply -f ./deployments/deployment-country-specific.yaml &&
kubectl apply -f ./deployments/deployment-backbone.yaml &&

# Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/dinorows/TCO490/master/kubernetes-dashboard-15.yaml


# Apply Services
kubectl apply -f ./services/service-all.yaml &&
kubectl apply -f ./services/service-countries.yaml &&
kubectl apply -f ./services/service-country-specific.yaml &&
kubectl apply -f ./services/service-backbone.yaml &&


# Get Backbone External-IP
sleep 15 &&
kubectl get svc covid19-backbone