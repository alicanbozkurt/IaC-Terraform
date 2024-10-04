output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "ec2_security_group_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.ec2.id
}

output "ecs_security_group_id" {
  description = "Security Group ID for ECS services"
  value       = aws_security_group.ecs.id
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS instances"
  value       = aws_security_group.rds.id
}