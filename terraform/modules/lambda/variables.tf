variable "function_name" {
  description = "Nome da Lambda function"
  type        = string
}

variable "role_arn" {
  description = "ARN da IAM Role usada pela Lambda"
  type        = string
}

variable "filename" {
  description = "Arquivo zip contendo o código da Lambda"
  type        = string
}

variable "table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
}
