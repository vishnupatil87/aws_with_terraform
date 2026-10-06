resource "aws_route53_zone" "main" {
  name = var.domain_name
  comment = "managed by terraform"
  force_destroy = true
}
