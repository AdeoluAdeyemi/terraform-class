resource "aws_s3_bucket_ownership_controls" "demo_bucket_cntr" {
    bucket = var.aws_s3_bucket_demo_id
    rule {
        object_ownership = var.aws_s3_bucket_object_ownership
    }
}