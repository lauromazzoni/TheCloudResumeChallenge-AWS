# Armazenando o tfstate em um bucket s3
terraform {
  backend "s3" {
    bucket = "awscloudhandson-terraform-state"
    key    = "resume-challenge/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project = "CloudResumeChallenge"
    }
  }
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

# Cria Hosted Zone + ACM
module "route53_acm" {
  source      = "./modules/route53-acm"
  domain_name = var.domain_name
}



# CloudFront usa o certificado gerado
module "cloudfront" {
  source                     = "./modules/cloudfront"
  s3_bucket_website_endpoint = module.s3_website.website_endpoint
  acm_certificate_arn        = module.route53_acm.certificate_arn
  domain_name                = var.domain_name
}

# Após CloudFront e ACM existirem, cria os registros DNS
module "route53_records" {
  source                    = "./modules/route53_records"
  zone_id                   = module.route53_acm.zone_id
  domain_name               = var.domain_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = var.cloudfront_hosted_zone_id
}

module "apigateway_domain" {
  source     = "./modules/apigateway_domain"
  domain_name = var.domain_name
  zone_id     = module.route53_acm.zone_id
  api_id      = module.apigateway.api_id
  stage_name  = module.apigateway.stage_name
}

output "api_custom_domain" {
  value = module.apigateway_domain.custom_domain_name
}
