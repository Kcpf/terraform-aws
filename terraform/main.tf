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

module "subnet" {
  source = "./subnet-module"

  vpc_id            = module.vpc.vpc_id
  subnet_name       = "TF Subnet"
  subnet_cidr_block = "192.168.1.0/24"
  subnet_zone       = "us-east-1a"
}

module "sg-mysql" {
  source = "./sg-module"

  security_group_vpc_id = module.vpc.vpc_id
  security_group_name   = "TF MySQL Security Group"
}

module "sg-rule-mysql-1" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-mysql.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 3306
  security_group_rule_to_port     = 3306
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-mysql-2" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-mysql.security_group_id
  security_group_rule_type        = "egress"
  security_group_rule_from_port   = 0
  security_group_rule_to_port     = 0
  security_group_rule_protocol    = "-1"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-postgres" {
  source = "./sg-module"

  security_group_vpc_id = module.vpc.vpc_id
  security_group_name   = "TF Postgres Security Group"
}

module "sg-rule-postgres-1" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-postgres.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 5432
  security_group_rule_to_port     = 5432
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-postgres-2" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-postgres.security_group_id
  security_group_rule_type        = "egress"
  security_group_rule_from_port   = 0
  security_group_rule_to_port     = 0
  security_group_rule_protocol    = "-1"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-web" {
  source = "./sg-module"

  security_group_vpc_id = module.vpc.vpc_id
  security_group_name   = "TF Web App Security Group"
}

module "sg-rule-web-1" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-web.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 80
  security_group_rule_to_port     = 80
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-web-2" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-web.security_group_id
  security_group_rule_type        = "ingress"
  security_group_rule_from_port   = 443
  security_group_rule_to_port     = 443
  security_group_rule_protocol    = "tcp"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "sg-rule-web-3" {
  source = "./sg-rule-module"

  security_group_id               = module.sg-web.security_group_id
  security_group_rule_type        = "egress"
  security_group_rule_from_port   = 0
  security_group_rule_to_port     = 0
  security_group_rule_protocol    = "-1"
  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "ec2-large-0" {
  source = "./ec2-module"

  instance_name      = "TF EC2 Large 0"
  instance_type      = "t3.large"
  instance_ami       = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
  instance_zone      = "us-east-1a"
  instance_subnet_id = module.subnet.subnet_id
  security_group_ids = [module.sg-mysql.security_group_id]
}

module "ec2-weak-1" {
  source = "./ec2-module"

  instance_name      = "TF EC2 Weak 1"
  instance_type      = "t3.micro"
  instance_ami       = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
  instance_zone      = "us-east-1a"
  instance_subnet_id = module.subnet.subnet_id
  security_group_ids = [module.sg-postgres.security_group_id]
}

module "ec2-medium-2" {
  source = "./ec2-module"

  instance_name      = "TF EC2 Medium 2"
  instance_type      = "t3.medium"
  instance_ami       = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
  instance_zone      = "us-east-1a"
  instance_subnet_id = module.subnet.subnet_id
  security_group_ids = [module.sg-web.security_group_id]
}

module "user-0" {
  source = "./user-module"

  user_name = "fernando"
}

module "user-1" {
  source = "./user-module"

  user_name = "francisco"
}
