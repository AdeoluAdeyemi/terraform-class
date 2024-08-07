
resource "aws_subnet" "main" {
    vpc_id     = var.aws_vpc_id
    cidr_block = var.aws_subnet_cidr_block

    tags = {
        Name = "tf_main_subnet"
    }
}
