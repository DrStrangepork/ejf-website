#############################################
#########cloudfront certificate#####################
#############################################

resource "aws_acm_certificate" "cloudfront_certificate" {
  domain_name = var.root_domain_name
  provider    = aws.cloudfront-certificate
  subject_alternative_names = [
    "www.${var.root_domain_name}"
  ]
  validation_method = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  tags = {
    Name = "website-certificate"
  }
  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_acm_certificate_validation" "my_certificate_validation" {
  certificate_arn         = aws_acm_certificate.cloudfront_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_val_records : record.fqdn]
  provider                = aws.cloudfront-certificate
}


#############################################
#########api gateway certificate#####################
#############################################

resource "aws_acm_certificate" "intake_api_certificate" {
  domain_name       = var.intake_api_domain
  validation_method = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  tags = {
    Name = "intake_api_certificate"
  }
  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_acm_certificate_validation" "intake_api_certificate_validation" {
  certificate_arn         = aws_acm_certificate.intake_api_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.intake_api_acm_val_records : record.fqdn]
}
