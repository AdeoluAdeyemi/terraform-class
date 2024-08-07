# Output variable definitions

output "arn" {
    description = "arn of subnet"
    value = aws_subnet.main.arn
}

output "id" {
    description = "Id of the subnet"
    value = aws_subnet.main.id
}