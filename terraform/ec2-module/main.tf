resource "aws_instance" "this" {
  for_each = var.instances_config

  ami           = lookup(each.value, "ami", null)
  instance_type = lookup(each.value, "type", null)
  vpc_security_group_ids = [
    aws_security_group.web.id
  ]
  subnet_id         = var.subnet_id
  availability_zone = lookup(each.value, "availability_zone", null)

  tags = {
    Name = "Terraform: ${lookup(each.value, "name", null)}"
  }
}
