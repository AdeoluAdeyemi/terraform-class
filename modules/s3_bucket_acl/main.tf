resource "aws_s3_bucket_acl" "demo_bucket_acl" {
    # depends_on = [
    #     #aws_s3_bucket_ownership_controls.demo_bucket_cntr,
    #     #aws_s3_bucket_public_access_block.demo_bucket_ac_bl
    #     var.aws_s3_bucket_ownership_controls_demo_bucket_cntr
    #     var.aws_s3_bucket_public_access_block_demo_bucket_ac_bl
    # ]
    bucket = var.aws_s3_bucket_demo_id
    acl    = var.aws_object_acl
}