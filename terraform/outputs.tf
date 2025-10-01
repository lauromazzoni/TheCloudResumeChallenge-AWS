# S3 Bucket outputs
output "s3_bucket_id" {
  description = "ID of the S3 bucket"
  value       = try(module.s3_website.bucket_id, "")
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = try(module.s3_website.bucket_domain_name, "")
}

# CloudFront outputs
output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = try(module.cloudfront.distribution_id, "")
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = try(module.cloudfront.domain_name, "")
}

# DynamoDB outputs
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = try(module.dynamodb.table_name, "")
}

# Lambda outputs
output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = try(module.lambda.function_name, "")
}

# API Gateway outputs
output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = try(module.api_gateway.api_url, "")
}

# Website URL
output "website_url" {
  description = "URL of the website"
  value       = var.domain_name != "" ? "https://${var.domain_name}" : try(module.cloudfront.domain_name, "")
}