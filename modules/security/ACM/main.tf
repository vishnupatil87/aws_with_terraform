resource "aws_acm_certificate" "cert" {
  domain_name       = vishji.in
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}