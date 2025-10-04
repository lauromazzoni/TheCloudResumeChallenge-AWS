variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
  default     = "resume-counter"
}

variable "lambda_role_name" {
  description = "Nome da role IAM para a Lambda"
  type        = string
  default     = "resume-counter-lambda-role"
}

variable "lambda_function_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "resumeCounterLambda"
}

variable "lambda_zip_file" {
  description = "Arquivo zip contendo o código da Lambda"
  type        = string
  default     = "lambda.zip"
}

variable "api_gateway_name" {
  description = "Nome da API Gateway"
  type        = string
  default     = "ResumeCounterAPI"
}

variable "api_gateway_stage" {
  description = "Stage da API Gateway (ex: prod)"
  type        = string
  default     = "prod"
}

variable "s3_bucket_name" {
  description = "Nome do bucket S3 do frontend (precisa ser globalmente único)"
  type        = string
  default     = "meu-curriculo-site"
}

variable "domain_name" {
  description = "Domínio raiz usado para o site (ex: vouaqui.com.br)"
  type        = string
  default     = "vouaqui.com.br"
}

variable "cloudfront_hosted_zone_id" {
  description = "Hosted zone ID padrão do CloudFront (fixo)"
  type        = string
  default     = "Z2FDTNDATAQYW2"
}
