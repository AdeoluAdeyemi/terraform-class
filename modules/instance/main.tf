resource "aws_instance" "app_server" {
    ami = var.aws_ami_id #"ami-08ef0be8e061f0c3f"
    instance_type = "t2.micro"
    subnet_id     = var.aws_subnet_id # Specify the subnet ID
    #security_groups = [aws_security_group.allow_tls.name]  # Use the security group

    # Reference the security group by ID
    vpc_security_group_ids = [var.vpc_security_group_ids]

    tags = {
        Name = "tf_ec2_instance"
    }
}