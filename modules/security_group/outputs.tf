# Output variable definition

output "id" {
    description = "Id of security group"
    value = aws_security_group.allow_tls.id
}


output "name" {
    description = "Name of security group"
    value = aws_security_group.allow_tls.name
}