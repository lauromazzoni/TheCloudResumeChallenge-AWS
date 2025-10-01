# AWS Region
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# Environment
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Project name
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "cloud-resume-challenge"
}

# Default tags
variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Cloud Resume Challenge"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# Domain name
variable "domain_name" {
  description = "Domain name for the website"
  type        = string
  default     = ""
}

# Certificate ARN
variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
  default     = ""
}