resource "aws_subnet" "this" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_zone

  tags = { Name = var.subnet_name }
}
