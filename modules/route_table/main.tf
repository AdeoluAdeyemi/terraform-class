resource "aws_route_table" "route_table_main" {
    vpc_id = var.aws_vpc_id

    route {
        cidr_block = var.aws_route_cidr_block
        gateway_id = var.aws_internet_gateway_id
    }

    # route {
    #     ipv6_cidr_block        = "::/0"
    #     egress_only_gateway_id = aws_egress_only_internet_gateway.route_table_main.id
    # }

    tags = {
        Name = "tf_route_table_main"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = var.aws_subnet_id
    route_table_id = aws_route_table.route_table_main.id
}
