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

# Configuração de website estático
resource "aws_s3_bucket_website_configuration" "static_site_bucket_website" {
  bucket = aws_s3_bucket.static_site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Configuração de acesso público
resource "aws_s3_bucket_public_access_block" "static_site_bucket_access" {
  bucket = aws_s3_bucket.static_site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política do bucket para acesso público (substitui o ACL)
resource "aws_s3_bucket_policy" "static_site_bucket_policy" {
  bucket     = aws_s3_bucket.static_site_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.static_site_bucket_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site_bucket.arn}/*"
      }
    ]
  })
}

# Output da URL do website
output "website_url" {
  value       = "http://${aws_s3_bucket_website_configuration.static_site_bucket_website.website_endpoint}"
  description = "URL do site estático"
}

output "bucket_name" {
  value       = aws_s3_bucket.static_site_bucket.id
  description = "Nome do bucket criado"
}
