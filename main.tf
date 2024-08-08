# - provider block
provider "aws" {
    region  = var.aws_region
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file(var.deployer)
}

module "vpc" {
    source = "./modules/vpc"
    aws_vpc_cidr_block = var.aws_vpc_cidr_block
}

module "subnet" {
    source = "./modules/subnet"
    aws_vpc_id = module.vpc.vpc_id
    aws_subnet_cidr_block = var.aws_subnet_cidr_block
}

module "internet_gateway" {
    source = "./modules/internet_gateway"
    aws_vpc_id = module.vpc.vpc_id
}

module "route_table" {
    source = "./modules/route_table"
    aws_vpc_id = module.vpc.vpc_id
    aws_internet_gateway_id = module.internet_gateway.internet_gw_id
    aws_subnet_id = module.subnet.id
    aws_route_cidr_block = var.aws_route_cidr_block
}

module "security_group" {
    source = "./modules/security_group"
    aws_vpc_id = module.vpc.vpc_id
    aws_vpc_cidr_block = var.aws_vpc_cidr_block
    aws_sg_cidr_ipv4 = var.aws_sg_cidr_ipv4
}

module "ami" {
    source = "./modules/ami"
}

module "instance" {
    source = "./modules/instance"
    aws_ami_id = module.ami.id
    aws_subnet_id = module.subnet.id
    vpc_security_group_ids = module.security_group.id
}