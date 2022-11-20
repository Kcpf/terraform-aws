# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Subnet A
output "subnet_id-a" {
  value = module.subnet-a.subnet_id
}

# Subnet B
output "subnet_id-b" {
  value = module.subnet-b.subnet_id
}

# EC2 A
output "instance_arn-a" {
  value = module.ec2-a.instance_arn
}

output "instance_name-a" {
  value = module.ec2-a.instance_name
}

output "instance_zone-a" {
  value = module.ec2-a.instance_zone
}

# EC2 B
output "instance_arn-b" {
  value = module.ec2-b.instance_arn
}

output "instance_name-b" {
  value = module.ec2-b.instance_name
}

output "instance_zone-b" {
  value = module.ec2-b.instance_zone
}

# User
output "account_arn-a" {
  value = module.user-a.account_arn
}

output "account_arn-b" {
  value = module.user-b.account_arn
}

output "account_arn-c" {
  value = module.user-c.account_arn
}
