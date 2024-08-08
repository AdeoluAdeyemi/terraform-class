variable "aws_vpc_id" {
    description = "Id of VPC"
    type = string
}

variable "aws_vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type = string  
}

variable "aws_sg_cidr_ipv4" {
    description = "CIDR block for the Security Group"
    type = string  
}