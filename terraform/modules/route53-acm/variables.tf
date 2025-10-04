variable "domain_name" {
  description = "Domínio principal (ex: vouaqui.com.br)"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Domain name da distribuição CloudFront (ex: dxxxxx.cloudfront.net)"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "Hosted zone ID do CloudFront (fixo para todas distros)"
  type        = string
}
