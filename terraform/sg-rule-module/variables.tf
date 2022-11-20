variable "security_group_id" {
  description = "The ID of the security group to modify."
  type        = string
}

variable "security_group_rule_type" {
  type        = string
  description = "The type of rule to create. Valid values are ingress (inbound) or egress (outbound)."
}

variable "security_group_rule_from_port" {
  type        = number
  description = "The start port (or ICMP type number if protocol is \"icmp\")."
}

variable "security_group_rule_to_port" {
  type        = number
  description = "The end port (or ICMP code if protocol is \"icmp\")."
}

variable "security_group_rule_protocol" {
  type        = string
  description = "The protocol. If not icmp, tcp, udp, or all use the -1 protocol number."
}

variable "security_group_rule_cidr_blocks" {
  type        = list(string)
  description = "A list of CIDR blocks."
}
