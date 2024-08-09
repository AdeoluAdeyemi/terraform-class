#provider block
provider "aws" {
    region = var.aws_region
}

#aws_vpc
resource "aws_vpc" "classwork_iac_vpc_main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "classwork_iac_main"
    }
}



# aws_subnet
resource "aws_subnet" "classwork_iac_main_subnet" {
    vpc_id     = aws_vpc.classwork_iac_vpc_main.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "classwork_iac_main_subnet"
    }
}

# aws_internet_gateway
resource "aws_internet_gateway" "classwork_iac_gw" {
    vpc_id = aws_vpc.classwork_iac_vpc_main.id

    tags = {
        Name = "classwork_iac_main_gw"
    }
}

# aws_route_table
resource "aws_route_table" "classwork_iac_main_rt" {
    vpc_id = aws_vpc.classwork_iac_vpc_main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.classwork_iac_gw.id
    }

    # route {
    #     ipv6_cidr_block        = "::/0"
    #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
    # }

    tags = {
        Name = "classwork_iac_main_rt"
    }
}

# aws_route_table_association
resource "aws_route_table_association" "classwork_iac_main_rt_assoc_a" {
    subnet_id      = aws_subnet.classwork_iac_main_subnet.id
    route_table_id = aws_route_table.classwork_iac_main_rt.id
}

# resource "aws_route_table_association" "classwork_iac_main_rt_assoc_b" {
#     gateway_id     = aws_internet_gateway.classwork_iac_gw.id
#     route_table_id = aws_route_table.classwork_iac_main_rt.id
# }

# aws_security_group
resource "aws_security_group" "classwork_iac_sg_main" {
    name        = "classwork_iac_sg_main"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id      = aws_vpc.classwork_iac_vpc_main.id

    tags = {
        Name = "classwork_iac_sg_main"
    }
}

resource "aws_vpc_security_group_ingress_rule" "classwork_iac_sg_main_http" {
    security_group_id = aws_security_group.classwork_iac_sg_main.id
    cidr_ipv4         = aws_vpc.classwork_iac_vpc_main.cidr_block
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "classwork_iac_sg_main_https" {
    security_group_id = aws_security_group.classwork_iac_sg_main.id
    cidr_ipv4         = aws_vpc.classwork_iac_vpc_main.cidr_block
    from_port         = 443
    ip_protocol       = "tcp"
    to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "classwork_iac_sg_main_http" {
    security_group_id = aws_security_group.classwork_iac_sg_main.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}

# aws_key_pair
resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key-pair"
    public_key = file("/home/adeolu/.ssh/terraform_aws_id_rsa.pub")
}

# aws_ami
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

# aws_instance
resource "aws_instance" "classwork_iac_sg_web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.classwork_iac_main_subnet.id
    vpc_security_group_ids = [aws_security_group.classwork_iac_sg_main.id]

    tags = {
        Name = "classwork_iac_sg_main_instance"
    }
}