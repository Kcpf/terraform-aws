variable "instances_config" {
  type = map(object({
    name              = string
    type              = string
    ami               = string
    availability_zone = string
  }))
  description = "Instances Names, Types and AMI to create"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to create security group in"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to create instances in"
}
