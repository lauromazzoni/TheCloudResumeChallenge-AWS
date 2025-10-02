output "api_invoke_url" {
  description = "URL base da API Gateway"
  value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${data.aws_region.current.id}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}"
}

data "aws_region" "current" {}
