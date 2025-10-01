# Development environment configuration
terraform {
  required_version = ">= 1.0"

  # Uncomment and configure when using remote state
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket-dev"
  #   key    = "dev/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(var.default_tags, {
      Environment = "dev"
    })
  }
}

# DynamoDB module
module "dynamodb" {
  source = "../../modules/dynamodb"

  project_name = var.project_name
  environment  = "dev"
  tags         = var.default_tags
}

# Lambda module
module "lambda" {
  source = "../../modules/lambda"

  project_name         = var.project_name
  environment          = "dev"
  dynamodb_table_name  = module.dynamodb.table_name
  dynamodb_table_arn   = module.dynamodb.table_arn
  lambda_zip_path      = var.lambda_zip_path
  lambda_source_code_hash = var.lambda_source_code_hash
  tags                 = var.default_tags
}

# API Gateway module
module "api_gateway" {
  source = "../../modules/api_gateway"

  project_name        = var.project_name
  environment         = "dev"
  lambda_function_name = module.lambda.function_name
  lambda_invoke_arn   = module.lambda.invoke_arn
  tags                = var.default_tags
}

# S3 Website module
module "s3_website" {
  source = "../../modules/s3_website"

  project_name                  = var.project_name
  environment                   = "dev"
  cloudfront_distribution_arn   = module.cloudfront.distribution_arn
  tags                          = var.default_tags
}

# CloudFront module
module "cloudfront" {
  source = "../../modules/cloudfront"

  project_name                     = var.project_name
  environment                      = "dev"
  s3_bucket_id                     = module.s3_website.bucket_id
  s3_bucket_regional_domain_name   = module.s3_website.bucket_regional_domain_name
  domain_name                      = var.domain_name
  certificate_arn                  = var.certificate_arn
  tags                             = var.default_tags
}