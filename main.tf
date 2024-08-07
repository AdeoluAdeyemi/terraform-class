# - provider block
provider "aws" {
    region  = var.aws_region
}


module "vpc" {
    source = "modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
}

module "subnet" {
    source = "modules/subnet"
    vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
    source = "modules/internet_gateway"
}

module "route_table" {
    source = "modules/route_table"
}

module "ami" {
    source = "modules/ami"
}

module "instance" {
    source = "modules/instance"
}