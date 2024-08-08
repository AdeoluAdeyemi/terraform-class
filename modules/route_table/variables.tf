variable "aws_vpc_id" {
    description = "Id of VPC"
    type = string
}

variable "aws_internet_gateway_id" {
    description = "Id of internet gateway"
    type = string
}

variable "aws_route_cidr_block" {
    description = "route table cidr block"
    type = string  
}

variable "aws_subnet_id" {
    description = "Id of Subnet"
    type = string  
}