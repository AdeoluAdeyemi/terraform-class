resource "aws_s3_bucket_website_configuration" "demo_bucket_cnf" {
    bucket = var.aws_s3_bucket_demo_id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }

    routing_rule {
        condition {
            key_prefix_equals = "docs/"
        }
        redirect {
            replace_key_prefix_with = "documents/"
        }
    }
}