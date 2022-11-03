terraform {
  required_version = "1.3.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc-module"

  aws_region = var.aws_region
}

module "ec2" {
  source = "./ec2-module"

  instances_config = var.instances_config
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.subnet_ids["Public Terraform Subnet A"]
}

module "user" {
  source = "./user-module"
}
