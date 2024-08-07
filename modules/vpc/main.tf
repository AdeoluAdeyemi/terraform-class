resource "aws_vpc" "main" {
    cidr_block = var.aws_vpc_cidr_block
    instance_tenancy = "default"

    tags = {
        Name = "tf_main_vpc"
    }
}