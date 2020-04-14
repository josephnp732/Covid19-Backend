#!/usr/bin/env bash

rm ~/.kube/config-terraform-eks-covid19 &&
rm config_map_aws_auth.yaml &&
kubectl delete daemonsets,replicasets,services,deployments,pods,rc --all &&
terraform destroy --auto-approve &&
rm -r ./.terraform &&
rm terraform.tfstate