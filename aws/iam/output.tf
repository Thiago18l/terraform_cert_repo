output "access_key_id" {
  sensitive = true
  value     = aws_iam_access_key.access_key.id
}

output "access_secret_key" {
  sensitive = true
  value     = aws_iam_access_key.access_key.secret
}