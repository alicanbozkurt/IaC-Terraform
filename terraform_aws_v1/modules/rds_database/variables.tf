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


variable "db_password_secret_arn" {
  description = "The ARN of the secret in AWS Secrets Manager containing the DB password"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}
