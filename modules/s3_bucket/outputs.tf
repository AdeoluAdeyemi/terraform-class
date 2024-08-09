# Output variable definitions

output "arn" {
    description = "Name of bucket"
    value = aws_s3_bucket.demo_bucket.arn
}

output "id" {
    description = "Id of bucket"
    value = aws_s3_bucket.demo_bucket.id
}