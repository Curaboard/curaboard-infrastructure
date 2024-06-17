resource "aws_s3_bucket" "helm_chart_bucket" {
  bucket = var.s3_helm

  tags = {
    "project" = "helm-chart"
  }
}

# Enable versioning so you can see the full revision history of your state files
resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.helm_chart_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.helm_chart_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "grant_public_access" {
  bucket                  = aws_s3_bucket.helm_chart_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}