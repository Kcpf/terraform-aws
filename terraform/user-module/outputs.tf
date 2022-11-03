output "account_arns" {
  value = { for k, v in aws_iam_user.accounts : k => v.arn }
}


