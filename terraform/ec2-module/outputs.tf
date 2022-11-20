output "instance_arn" {
  value = aws_instance.this.arn
}

output "instance_name" {
  value = aws_instance.this.tags.Name
}

output "instance_zone" {
  value = aws_instance.this.availability_zone
}
