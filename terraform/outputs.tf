# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "route_table_association_ids" {
  value = module.vpc.route_table_association_ids
}

# EC2
output "instance_arns" {
  value = module.ec2.instance_arns
}

output "instance_names" {
  value = module.ec2.instance_names
}

output "instance_zones" {
  value = module.ec2.instance_zones
}

output "instance_public_ips" {
  value = module.ec2.instance_public_ips
}

# User
output "account_arns" {
  value = module.user.account_arns
}
