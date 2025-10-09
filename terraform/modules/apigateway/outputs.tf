output "api_invoke_url" {
  description = "URL base da API Gateway"
  value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${data.aws_region.current.id}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}"
}

output "api_id" {
  description = "ID da API Gateway criada"
  value       = aws_api_gateway_rest_api.this.id
}

output "stage_name" {
  description = "Nome do stage da API Gateway"
  value       = aws_api_gateway_stage.stage.stage_name
}
