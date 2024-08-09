# Output variable definitions

output "s3_bucket_arn" {
    description = "Name of bucket"
    value = module.s3_bucket.arn
}

output "s3_bucket_id" {
    description = "Id of bucket"
    value = module.s3_bucket.id
}

output "s3_bucket_domain" {
    description = "Domain of bucket"
    value = module.s3_bucket.domain
}