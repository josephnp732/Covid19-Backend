#!/usr/bin/env bash

# Terraform

terraform init &&
terraform plan &&
terraform apply --auto-approve &&

# Kubectl Setup
terraform output config_map_aws_auth > config_map_aws_auth.yaml &&
terraform output kubeconfig > ~/.kube/config-terraform-eks-covid19 &&
cp ~/.kube/config-terraform-eks-covid19 ~/.kube/config &&
export KUBECONFIG=~/.kube/config-terraform-eks-covid19:~/.kube/config &&
echo "export KUBECONFIG=${KUBECONFIG}" >>${HOME}/.bash_profile &&
kubectl apply -f config_map_aws_auth.yaml &&


# Apply Deployments
kubectl apply -f ./deployments/deployment-all.yaml &&
kubectl apply -f ./deployments/deployment-countries.yaml &&
kubectl apply -f ./deployments/deployment-country-specific.yaml &&
kubectl apply -f ./deployments/deployment-backbone.yaml &&

# Kubernetes Dashboard
kubectl create -f https://raw.githubusercontent.com/dinorows/TCO490/master/kubernetes-dashboard-15.yaml &&

# Apply Services
kubectl apply -f ./services/service-all.yaml &&
kubectl apply -f ./services/service-countries.yaml &&
kubectl apply -f ./services/service-country-specific.yaml &&
kubectl apply -f ./services/service-backbone.yaml &&

# Prometheus Deployment
kubectl create namespace monitoring &&
kubectl create -f ./prometheus/clusterRole.yaml &&
kubectl create -f ./prometheus/config-map.yaml &&
kubectl create -f ./prometheus/prometheus-deployment.yaml &&
kubectl create -f ./prometheus/prometheus-service.yaml --namespace=monitoring &&

# Grafana Deployment
kubectl create -f ./grafana/grafana-datasource-config.yaml &&
kubectl create -f ./grafana/grafana-datasource-deploy.yaml &&
kubectl create -f ./grafana/grafana-datasource-service.yaml &&

# Get Backbone Hostname
sleep 15 &&
echo "Service API Hostname" &&
kubectl get svc covid19-backbone -o json | jq .status.loadBalancer.ingress[0].hostname &&

# Get Grafana Hostname
echo "Grafana Hostname" &&
kubectl get svc -n monitoring grafana -o json | jq .status.loadBalancer.ingress[0].hostname &&

# Get Kuberbetes Dashboard Hostname
echo "Kubernetes Dashboard Hostname" &&
kubectl get svc kubernetes-dashboard -n kube-system -o json | jq .status.loadBalancer.ingress[0].hostname