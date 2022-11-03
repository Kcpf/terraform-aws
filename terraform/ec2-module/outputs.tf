output "instance_arns" {
  value = { for k, v in aws_instance.this : k => v.arn }
}

output "instance_names" {
  value = { for k, v in aws_instance.this : k => v.tags.Name }
}

output "instance_zones" {
  value = { for k, v in aws_instance.this : k => v.availability_zone }
}

output "instance_public_ips" {
  value = { for k, v in aws_instance.this : k => v.public_ip }
}

output "security_group_web_id" {
  value = aws_security_group.web.id
}
