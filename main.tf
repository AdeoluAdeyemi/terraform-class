module "provider" {
    source = "modules/provider"
}

module "vpc" {
    source = "modules/vpc"
    cidr_block
}

module "subnet" {
    source = "modules/subnet"
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