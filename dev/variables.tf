variable "environment" {
  description = "The environment to deploy (e.g., dev, staging, prod)"
  type        = string
}

variable "subenv" {
  description = "The sub-environment to deploy (e.g., integration, performance)"
  type        = string
  default     = ""
}

variable "type" {
  description = "The type of the object (e.g., db, instance, k8s_cluster, container)"
  type        = string
}
