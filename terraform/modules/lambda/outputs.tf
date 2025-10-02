output "function_name" {
  description = "Nome da Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN da Lambda function"
  value       = aws_lambda_function.this.arn
}
