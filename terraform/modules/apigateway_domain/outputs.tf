output "custom_domain_name" {
  description = "Domínio customizado configurado no API Gateway"
  value       = aws_api_gateway_domain_name.api_domain.domain_name
}

output "api_domain_dns_record" {
  description = "Registro DNS público da API (api.<domínio>)"
  value       = aws_route53_record.api_dns.fqdn
}
