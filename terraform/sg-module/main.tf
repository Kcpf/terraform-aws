resource "aws_security_group" "this" {
  name   = var.security_group_name
  vpc_id = var.security_group_vpc_id

  tags = { Name = var.security_group_name }
}
