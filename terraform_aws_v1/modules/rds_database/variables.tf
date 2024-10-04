variable "combined_objects" {
  type = list(any)
}

variable "env" {
  type = string
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}


#variable "db_password_secret_arn" {
#  description = "The ARN of the secret in AWS Secrets Manager containing the DB password"
#  type        = string
#}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for RDS instances"
  type        = string
}