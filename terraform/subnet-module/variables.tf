variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_name" {
  type        = string
  description = "Subnet Name"
}

variable "subnet_cidr_block" {
  type        = string
  description = "Subnet CIDR Block"
}

variable "subnet_zone" {
  type        = string
  description = "Subnet Zone"
}
