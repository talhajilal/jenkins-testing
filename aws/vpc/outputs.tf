################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.this[0].id, null)
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.this[0].arn, null)
}

output "default_sg" {
  description = "The ARN of the VPC"
  value = try(aws_vpc.this[0].default_security_group_id, null)
  }

output "private_1_subnet_us_1" {
  description = "Private subnet in us-east-1a."
  value = aws_subnet.private_1_subnet_us-east_1a.id
}

output "public_1_subnet_us_1" {
  description = "Private subnet in us-east-1a."
  value = aws_subnet.public_subnet_us-east_1a.id
}