resource "aws_s3_bucket_public_access_block" "demo_bucket_ac_bl" {
    bucket = var.aws_s3_bucket_demo_id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "demo_bucket_cntr" {
    bucket = var.aws_s3_bucket_demo_id
    rule {
        object_ownership = var.aws_s3_bucket_object_ownership
    }
}

resource "aws_s3_bucket_acl" "demo_bucket_acl" {
    depends_on = [
        aws_s3_bucket_ownership_controls.demo_bucket_cntr,
        aws_s3_bucket_public_access_block.demo_bucket_ac_bl
    ]
    bucket = var.aws_s3_bucket_demo_id
    acl    = var.aws_object_acl
}