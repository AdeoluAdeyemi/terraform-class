resource "aws_s3_bucket_public_access_block" "demo_bucket_ac_bl" {
    bucket = var.aws_s3_bucket_demo_id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}
