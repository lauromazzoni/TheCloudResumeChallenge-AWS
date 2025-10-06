variable "api_name" {
  description = "Nome da API Gateway"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN da Lambda"
  type        = string
}

variable "lambda_name" {
  description = "Nome da função Lambda"
  type        = string
}

variable "stage_name" {
  description = "Stage da API Gateway (ex: prod)"
  type        = string
}
