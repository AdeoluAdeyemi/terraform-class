resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
    bucket = var.aws_s3_bucket_demo_id
    policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
    statement {
        principals {
        type        = "AWS"
        identifiers = ["*"]
        }

        actions = [
        "s3:GetObject",
        "s3:ListBucket",
        ]

        resources = [
        var.aws_s3_bucket_demo_arn,
        "${var.aws_s3_bucket_demo_arn}/*",
        ]
    }
}