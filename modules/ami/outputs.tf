# Output variable definition

output "id" {
    description = "Id of the AMI"
    value = data.aws_ami.ubuntu.id
}