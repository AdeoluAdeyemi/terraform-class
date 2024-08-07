# Output variable definitions

output "vpc_vpc_id" {
    description = "Id of the VPC"
    value = module.vpc.vpc_id
}