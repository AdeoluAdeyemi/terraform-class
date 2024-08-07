# Block for terraform settings including required provider
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }

    required_version = ">= 1.2.0"
}

# - provider block
provider "aws" {
    region  = "us-east-1"
}


# - aws_vpc
resource "aws_vpc" "main" {
    cidr_block       = "0.0.0.0/0"
    instance_tenancy = "default"

    tags = {
        Name = "main"
    }
}

# - aws_subnet
resource "aws_subnet" "main" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "0.0.0.0/0"

    tags = {
        Name = "Main"
    }
}

# - aws_internet_gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main"
    }
}

# - aws_route_table
resource "aws_route_table" "route_table_main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    route {
        ipv6_cidr_block        = "::/0"
        egress_only_gateway_id = aws_egress_only_internet_gateway.route_table_main.id
    }

    tags = {
        Name = "route_table_main"
    }
}
# - aws_route_table_association
resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.main.id
    route_table_id = aws_route_table.route_table_main.id
}

resource "aws_route_table_association" "b" {
    gateway_id     = aws_internet_gateway.gw.id
    route_table_id = aws_route_table.route_table_main.id
}

# - aws_security_group
resource "aws_security_group" "allow_tls" {
    name        = "allow_tls"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id      = aws_vpc.main.id

    tags = {
        Name = "allow_tls"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4         = aws_vpc.main.cidr_block
    from_port         = 443
    ip_protocol       = "tcp"
    to_port           = 443
}

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
#     security_group_id = aws_security_group.allow_tls.id
#     cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
#     from_port         = 443
#     ip_protocol       = "tcp"
#     to_port           = 443
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#     security_group_id = aws_security_group.allow_tls.id
#     cidr_ipv6         = "::/0"
#     ip_protocol       = "-1" # semantically equivalent to all ports
# }


# - aws_key_pair
resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file("/home/adeolu/.ssh/terraform_aws_id_rsa.pub")
}


# - aws_ami
# data "aws_ami" "example" {
#     executable_users = ["self"]
#     most_recent      = true
#     name_regex       = "^myami-\\d{3}"
#     owners           = ["self"]

#     filter {
#         name   = "name"
#         values = ["myami-*"]
#     }

#     filter {
#         name   = "root-device-type"
#         values = ["ebs"]
#     }

#     filter {
#         name   = "virtualization-type"
#         values = ["hvm"]
#     }
# }

# - aws_instance
resource "aws_instance" "app_server" {
    ami = "ami-830c94e3"
    instance_type = "t2.micro"

    tags = {
        Name = "ExampleAppServerInstance"
    }
}