output "bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.this.bucket
}

output "website_endpoint" {
  description = "Endpoint público do S3 (modo estático)"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}
