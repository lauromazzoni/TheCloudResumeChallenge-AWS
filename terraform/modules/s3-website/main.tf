resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

# Política pública para acesso ao site
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
    depends_on = [aws_s3_bucket_public_access_block.this]
}

# Habilita website hosting
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# (Opcional) Bloqueio de versionamento / ACL
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Esvazia o bucket antes de destruí-lo
resource "null_resource" "empty_bucket" {
  triggers = {
    bucket_name = aws_s3_bucket.this.bucket
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws s3 rm s3://${self.triggers.bucket_name} --recursive"
  }

  depends_on = [aws_s3_bucket.this]
}

