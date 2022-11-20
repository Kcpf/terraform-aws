resource "aws_security_group_rule" "this" {
  type              = var.security_group_rule_type
  from_port         = var.security_group_rule_from_port
  to_port           = var.security_group_rule_to_port
  protocol          = var.security_group_rule_protocol
  cidr_blocks       = var.security_group_rule_cidr_blocks
  security_group_id = var.security_group_id
}
