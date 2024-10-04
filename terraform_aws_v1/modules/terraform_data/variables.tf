variable "env" {
  description = "Environment name"
  type        = string
}

variable "objects" {
  description = "Map of objects to create"
  type        = map(any)
}

variable "subenv_objects" {
  description = "Map of sub-environment objects to create"
  type        = map(any)
}
