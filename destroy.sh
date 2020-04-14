#!/usr/bin/env bash

# kubectl delete all --all --all-namespaces &&
rm ~/.kube/config-terraform-eks-covid19 &&
rm config_map_aws_auth.yaml &&
terraform destroy --auto-approve &&
rm -r ./.terraform &&
rm terraform.tfstate