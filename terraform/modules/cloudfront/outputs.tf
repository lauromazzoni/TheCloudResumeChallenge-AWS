output "cloudfront_domain_name" {
  description = "Domain name da distribuição CloudFront"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_id" {
  description = "ID da distribuição CloudFront"
  value       = aws_cloudfront_distribution.this.id
}
