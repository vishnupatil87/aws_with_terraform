resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.environment}-new-terraform-july5851"
    environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning
  }
}
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = var.aws_s3_bucket_acl
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}