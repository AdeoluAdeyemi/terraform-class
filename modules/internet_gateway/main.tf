resource "aws_internet_gateway" "gw" {
    vpc_id = var.aws_vpc_id

    tags = {
        Name = "tf_main_gw"
    }
}