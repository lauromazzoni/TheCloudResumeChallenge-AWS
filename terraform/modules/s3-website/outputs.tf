output "bucket_name" {
  description = "Nome do bucket do site"
  value       = aws_s3_bucket.this.bucket
}

output "website_endpoint" {
  description = "Endpoint público do S3 Website"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}
