variable "instance_name" {
  type        = string
  description = "Instance Name"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "instance_ami" {
  type        = string
  description = "Instance AMI"
}

variable "instance_zone" {
  type        = string
  description = "Instance Zone"
}

variable "instance_subnet_id" {
  type        = string
  description = "Subnet ID to create instance in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security Group IDs to attach to instance"
}
