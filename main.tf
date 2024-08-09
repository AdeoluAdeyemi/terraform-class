# - provider block
provider "aws" {
    region  = var.aws_region
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file(var.deployer)
}

module "s3_bucket" {
    source = "./modules/s3_bucket"
    aws_bucket_name = var.aws_bucket_name
}

module "aws_s3_bucket_website_configuration" {
    source = "./modules/s3_bucket_website_configuration"
    aws_s3_bucket_demo_id = module.s3_bucket.id
}

# module "s3_bucket_ownership_controls" {
#     source = "./modules/s3_bucket_ownership_controls"
#     aws_s3_bucket_demo_id = module.s3_bucket.id
#     aws_s3_bucket_object_ownership = var.aws_s3_bucket_object_ownership
# }

# module "s3_bucket_public_access_block" {
#     source = "./modules/s3_bucket_public_access_block"
#     aws_s3_bucket_demo_id = module.s3_bucket.id
# }

module "s3_bucket_acl" {
    source = "./modules/s3_bucket_acl"
    aws_s3_bucket_demo_id = module.s3_bucket.id
    aws_object_acl = var.aws_object_acl
    aws_s3_bucket_object_ownership = var.aws_s3_bucket_object_ownership
}

module "aws_s3_bucket_policy" {
    source = "./modules/s3_bucket_policy"
    aws_s3_bucket_demo_id = module.s3_bucket.id
    aws_s3_bucket_demo_arn = module.s3_bucket.arn
}