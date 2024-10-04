variable "combined_objects" {
  type = list(any)
}

variable "env" {
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS services"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS services"
  type        = list(string)
}
