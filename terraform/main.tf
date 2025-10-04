provider "aws" {
  region = var.aws_region
}

# DynamoDB
module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.dynamodb_table_name
}

# IAM Role
module "iam" {
  source    = "./modules/iam"
  role_name = var.lambda_role_name
}

# Lambda
module "lambda" {
  source        = "./modules/lambda"
  function_name = var.lambda_function_name
  role_arn      = module.iam.role_arn
  filename      = var.lambda_zip_file
  table_name    = module.dynamodb.table_name
}

# API Gateway
module "apigateway" {
  source            = "./modules/apigateway"
  api_name          = var.api_gateway_name
  lambda_invoke_arn = module.lambda.function_arn
  lambda_name       = module.lambda.function_name
  stage_name        = var.api_gateway_stage
}

# S3 Website
module "s3_website" {
  source      = "./modules/s3-website"
  bucket_name = var.s3_bucket_name
}

# CloudFront
module "cloudfront" {
  source                     = "./modules/cloudfront"
  s3_bucket_website_endpoint = module.s3_website.website_endpoint
  acm_certificate_arn        = module.route53_acm.certificate_arn
  domain_name                = var.domain_name
}

# Route53 + ACM
module "route53_acm" {
  source                    = "./modules/route53-acm"
  domain_name               = var.domain_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = var.cloudfront_hosted_zone_id
}
