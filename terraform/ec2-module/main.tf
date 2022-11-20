resource "aws_instance" "this" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.instance_subnet_id
  availability_zone      = var.instance_zone

  tags = {
    Name = var.instance_name
  }
}
