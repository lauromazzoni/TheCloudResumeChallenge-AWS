output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = module.dynamodb.table_name
}

output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = module.lambda.function_arn
}

output "api_gateway_url" {
  description = "URL base da API Gateway"
  value       = module.apigateway.api_invoke_url
}

output "s3_bucket_name" {
  description = "Nome do bucket S3 que hospeda o frontend"
  value       = module.s3_website.bucket_name
}

output "s3_website_endpoint" {
  value       = module.s3_website.website_endpoint
  description = "Endpoint do website S3"
}

output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "Domain name público da distribuição CloudFront"
  value       = module.cloudfront.cloudfront_domain_name
}

output "certificate_arn" {
  description = "ARN do certificado ACM validado"
  value       = module.route53_acm.certificate_arn
}

output "route53_zone_id" {
  description = "ID da hosted zone Route53"
  value       = module.route53_acm.zone_id
}

output "api_custom_domain" {
  description = "Domínio fixo da API Gateway"
  value       = module.apigateway_domain.custom_domain_name
}
