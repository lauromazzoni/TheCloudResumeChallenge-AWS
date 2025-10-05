output "certificate_arn" {
  description = "ARN do certificado ACM validado"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "zone_id" {
  description = "ID da Hosted Zone criada"
  value       = aws_route53_zone.this.zone_id
}
