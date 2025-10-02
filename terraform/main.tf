provider "aws" {
  region = "us-east-1"
}

# DynamoDB
module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = "resume-counter"
}

# IAM Role
module "iam" {
  source    = "./modules/iam"
  role_name = "resume-counter-lambda-role"
}

# Lambda
module "lambda" {
  source        = "./modules/lambda"
  function_name = "resumeCounterLambda"
  role_arn      = module.iam.role_arn
  filename      = "lambda.zip"
  table_name    = module.dynamodb.table_name
}

# API Gateway
module "apigateway" {
  source           = "./modules/apigateway"
  api_name         = "ResumeCounterAPI"
  lambda_invoke_arn = module.lambda.function_arn
  lambda_name      = module.lambda.function_name
  stage_name       = "prod"
}

# S3 Website
module "s3_website" {
  source      = "./modules/s3-website"
  bucket_name = "meu-curriculo-site" # ajuste o nome único
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "lambda_function_arn" {
  value = module.lambda.function_arn
}

output "api_gateway_url" {
  value = module.apigateway.api_invoke_url
}

output "s3_bucket_name" {
  value = module.s3_website.bucket_name
}

output "s3_website_endpoint" {
  value = module.s3_website.website_endpoint
}

# CloudFront
module "cloudfront" {
  source                    = "./modules/cloudfront"
  s3_bucket_website_endpoint = module.s3_website.website_endpoint
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain_name
}