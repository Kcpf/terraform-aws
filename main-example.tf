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
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc-module"

  vpc_name       = "TF VPC"
  vpc_cidr_block = "192.168.0.0/16"
}

module "subnet-a" {
  source = "./subnet-module"

  vpc_id            = module.vpc.vpc_id
  subnet_name       = "TF Subnet A"
  subnet_cidr_block = "192.168.1.0/24"
  subnet_zone       = "us-east-1a"
}

module "subnet-b" {
  source = "./subnet-module"

  vpc_id            = module.vpc.vpc_id
  subnet_name       = "TF Subnet B"
  subnet_cidr_block = "192.168.2.0/24"
  subnet_zone       = "us-east-1b"
}

module "sg-a" {
  source = "./sg-module"

  security_group_vpc_id = module.vpc.vpc_id
  security_group_name   = "TF SG-A"
}

module "sg-rule-a" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-a.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 22
  security_group_rule_to_port     = 22
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-b" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-a.security_group_id
  security_group_rule_type        = "egress"
  security_group_rule_from_port   = 0
  security_group_rule_to_port     = 0
  security_group_rule_protocol    = "-1"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-b" {
  source = "./sg-module"

  security_group_vpc_id = module.vpc.vpc_id
  security_group_name   = "TF SG-B"
}

module "sg-rule-c" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-b.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 80
  security_group_rule_to_port     = 80
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-d" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-b.security_group_id
  security_group_rule_type        = "egress"
  security_group_rule_from_port   = 0
  security_group_rule_to_port     = 0
  security_group_rule_protocol    = "-1"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "ec2-a" {
  source = "./ec2-module"

  instance_name      = "TF Web server"
  instance_type      = "t3.medium"
  instance_ami       = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
  instance_zone      = "us-east-1a"
  instance_subnet_id = module.subnet-a.subnet_id
  security_group_ids = [module.sg-a.security_group_id]
}

module "ec2-b" {
  source = "./ec2-module"

  instance_name      = "TF CI/CD Server"
  instance_type      = "t3.micro"
  instance_ami       = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
  instance_zone      = "us-east-1b"
  instance_subnet_id = module.subnet-b.subnet_id
  security_group_ids = [module.sg-b.security_group_id]
}

module "user-a" {
  source = "./user-module"

  user_name = "TF-User-A"
}

module "user-b" {
  source = "./user-module"

  user_name = "TF-User-B"
}

module "user-c" {
  source = "./user-module"

  user_name = "TF-User-C"
}
