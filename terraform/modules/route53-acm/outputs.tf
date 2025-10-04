output "zone_id" {
  description = "ID da hosted zone no Route53"
  value       = aws_route53_zone.this.zone_id
}

output "certificate_arn" {
  description = "ARN do certificado ACM validado"
  value       = aws_acm_certificate.this.arn
}
