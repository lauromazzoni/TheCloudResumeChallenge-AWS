variable "domain_name" {
  description = "Domínio raiz (ex: awscloudhandson.com)"
  type        = string
}

variable "zone_id" {
  description = "ID da hosted zone no Route53"
  type        = string
}

variable "api_id" {
  description = "ID da API Gateway REST API"
  type        = string
}

variable "stage_name" {
  description = "Nome do stage da API Gateway (ex: prod)"
  type        = string
}
