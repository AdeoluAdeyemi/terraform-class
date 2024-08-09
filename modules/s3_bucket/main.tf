resource "aws_s3_bucket" "demo_bucket" {
    bucket = var.aws_bucket_name

    tags = {
        Name        = "TF bucket"
        Environment = "Dev"
    }
}