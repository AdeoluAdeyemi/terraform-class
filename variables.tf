variable "aws_region" {
    description = "AWS Region"
    type =  string
}

variable "deployer" {
    description = "Ker/Pair value"
    type = string
}

variable "aws_bucket_name" {
    description = "Name of the S3 bucket. Must be unique"
    type = string
}


variable "aws_object_acl" {
    description = "S3 bucket object ACL"
    type = string
}


variable "aws_s3_bucket_object_ownership" {
    description = "Name of S3 bucket object ownership"
    type = string
}