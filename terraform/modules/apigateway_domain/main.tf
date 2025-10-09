data "aws_region" "current" {}

# Certificado para o subdomínio (já pode usar o mesmo módulo ACM se quiser)
resource "aws_acm_certificate" "api" {
  domain_name       = "api.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "api_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "api" {
  certificate_arn         = aws_acm_certificate.api.arn
  validation_record_fqdns = [for record in aws_route53_record.api_cert_validation : record.fqdn]
}

# Custom domain no API Gateway
resource "aws_api_gateway_domain_name" "api_domain" {
  domain_name              = "api.${var.domain_name}"
  regional_certificate_arn = aws_acm_certificate_validation.api.certificate_arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Mapping para o stage "prod"
resource "aws_api_gateway_base_path_mapping" "api_mapping" {
  api_id      = var.api_id
  stage_name  = var.stage_name
  domain_name = aws_api_gateway_domain_name.api_domain.domain_name
}

# Registro DNS no Route53
resource "aws_route53_record" "api_dns" {
  zone_id = var.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_api_gateway_domain_name.api_domain.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_domain.regional_zone_id
    evaluate_target_health = false
  }
}
