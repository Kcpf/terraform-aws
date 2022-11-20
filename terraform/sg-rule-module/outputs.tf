output "security_group_rule" {
  value = {
    security_group_id = aws_security_group_rule.this.security_group_id
    type              = aws_security_group_rule.this.type
    from_port         = aws_security_group_rule.this.from_port
    to_port           = aws_security_group_rule.this.to_port
    protocol          = aws_security_group_rule.this.protocol
  }
}
