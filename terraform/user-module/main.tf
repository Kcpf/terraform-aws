resource "aws_iam_user" "accounts" {
  for_each = toset(["TF-1", "TF-2", "TF-3", "TF-4"])
  name     = each.key
}
