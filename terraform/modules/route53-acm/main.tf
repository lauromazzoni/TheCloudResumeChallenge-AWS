# Hosted Zone no Route53 (assume que você já é dono do domínio e ele está registrado na AWS ou apontado pro Route53)
resource "aws_route53_zone" "this" {
  name = var.domain_name
}

# Certificado SSL no ACM (tem que ser us-east-1 porque CloudFront só aceita nessa região)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "this" {
  provider          = aws.us_east_1
  domain_name       = var.domain_name          # raiz: vouaqui.com.br
  validation_method = "DNS"
  tags = { Project = "ResumeSite" }  # a tag é utilizada uma uma IAM policy

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Alias raiz (vouaqui.com.br -> CloudFront)
resource "aws_route53_record" "alias_cloudfront_root" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}


# Cria os records DNS para validar o certificado
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# Aguarda validação do certificado
resource "aws_acm_certificate_validation" "this" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Record no Route53 apontando pro CloudFront
resource "aws_route53_record" "alias_cloudfront" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
