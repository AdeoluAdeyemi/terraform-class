variable "aws_region" {
    description = "AWS Region"
    type =  string
}

variable "deployer" {
    description = "Ker/Pair value"
    type = string
}

variable "aws_vpc_cidr_block" {
    description = "Name of VPC CIDR Block"
    type = string
}

variable "aws_subnet_cidr_block" {
    description = "Name of the subnet. Must be unique."
    type = string
}

variable "aws_sg_cidr_ipv4" {
    description = "CIDR block for the Security Group"
    type = string  
}

variable "aws_route_cidr_block" {
    description = "route table cidr block"
    type = string  
}