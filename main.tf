provider "aws" {
  region  = "us-west-2"
  version = ">= 2.38.0"
}

module "eks" {
  source = "./eks"
}

output "config_map_aws_auth_cout" {
  value = "${module.eks.config_map_aws_auth}"
}

output "kubeconfig_out" {
  value = "${module.eks.kubeconfig}"
}

##test line