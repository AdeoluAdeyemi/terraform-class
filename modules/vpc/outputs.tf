# Output variable definitions

output "arn" {
    description = "ARN of the vpc"
    value       = aws_vpc.main.arn
}

output "vpc_id" {
    description = "Name (id) of the vpc"
    value       = aws_vpc.main.id
}
