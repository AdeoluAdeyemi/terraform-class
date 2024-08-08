# - provider block
provider "aws" {
    region  = var.aws_region
}

resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file(var.deployer)
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
    vpc_id = module.vpc.vpc_id
}

module "route_table" {
    source = "modules/route_table"
    vpc_id = module.vpc.vpc_id
    gateway_id = module.internet_gateway.internet_gw_id
    subnet_id = module.subnet.id
}

module "security_group" {
    source = "modules/security_group"
    vpc_id = module.vpc.vpc_id
}

# module "ami" {
#     source = "modules/ami"
# }

module "instance" {
    source = "modules/instance"
    subnet_id = module.subnet.id
    vpc_security_group_ids = module.security_group.id
}