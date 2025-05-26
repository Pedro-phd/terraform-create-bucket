provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  type = string
}


resource "aws_s3_bucket" "static_site_bucket" {
  bucket = "static-site-bucket-${var.bucket_name}"
  tags = {
    name        = "Static Site Bucket"
    environment = "prod"
  }
}

resource "aws_s3_bucket_public_access_block" "static_site_bucket_access" {
  bucket = aws_s3_bucket.static_site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "static_site_bucket_ownership" {
  bucket = aws_s3_bucket.static_site_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "static_site_bucket_acl" {
  bucket = aws_s3_bucket.static_site_bucket.id
  acl    = "public-read"
}
