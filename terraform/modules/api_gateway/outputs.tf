output "api_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.visitor_api.id
}

output "api_arn" {
  description = "ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.visitor_api.arn
}

output "api_url" {
  description = "URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.visitor_api.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${aws_api_gateway_stage.visitor_stage.stage_name}"
}

output "stage_name" {
  description = "Name of the API Gateway stage"
  value       = aws_api_gateway_stage.visitor_stage.stage_name
}

data "aws_region" "current" {}