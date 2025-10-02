output "role_name" {
  description = "Nome da role criada"
  value       = aws_iam_role.lambda_exec.name
}

output "role_arn" {
  description = "ARN da role criada"
  value       = aws_iam_role.lambda_exec.arn
}
