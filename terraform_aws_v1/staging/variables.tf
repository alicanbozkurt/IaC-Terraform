variable "env" {
  description = "Environment name"
  type        = string
}

variable "objects" {
  description = "Map of objects to create"
  type        = map(any)
  default     = {}
}

variable "subenv_objects" {
  description = "Map of sub-environment objects to create"
  type        = map(any)
}

# Variables for RDS database module
variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
  #default     = "admin"
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

# Variables for ECS service module
# variable "ec2_subnet_id" {
#   description = "Subnet ID for EC2 instances"
#   type        = string
# }

variable "ecs_subnet_ids" {
  description = "List of subnet IDs for ECS services"
  type        = list(string)
}

variable "ecs_security_group_ids" {
  description = "List of security group IDs for ECS services"
  type        = list(string)
}
