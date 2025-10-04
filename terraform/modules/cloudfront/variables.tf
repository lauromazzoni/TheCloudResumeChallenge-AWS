variable "s3_bucket_website_endpoint" {
  description = "Endpoint de website do bucket S3"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN do certificado ACM válido no us-east-1"
  type        = string
}

variable "domain_name" {
  description = "Domínio raiz (ex: vouaqui.com.br)"
  type        = string
}
