variable "environments" {
  description = "Combined resource definitions for all environments"
  type = map(object({
    sub_env = optional(map(object({
      objects = map(object({
        type                = string
        size                = string
        count               = number
        parent_obj_type     = optional(string)
        additional_parameters = optional(map(any))
      }))
    })))
    objects = map(object({
      type                = string
      size                = string
      count               = number
      parent_obj_type     = optional(string)
      additional_parameters = optional(map(any))
    }))
  }))
}

variable "env" {
  description = "The target environment (e.g., dev, staging, prod)"
  type        = string
}

locals {
  # Extract all resources for the specific environment, including sub-environments
  main_env = lookup(var.environments, var.env, null)

  # Merge main environment objects and sub-environments
  all_objects = flatten([
    for sub_env_name, sub_env_value in lookup(main_env, "sub_env", {}) : [
      for object_name, object_value in sub_env_value.objects : {
        name = format("%s-%s-%s-%s-%02d", var.env, sub_env_name, object_value.type, object_name, index(sub_env_value.objects, object_name) + 1)
        data = object_value
      }
    ]
  ] + [
    for object_name, object_value in main_env.objects : {
      name = format("%s-%s-%02d", var.env, object_name, index(main_env.objects, object_name) + 1)
      data = object_value
    }
  ])
}

# Generate the naming convention and additional attributes for each object
locals {
  resource_definitions = {
    for object in local.all_objects : object.name => {
      type                 = object.data.type
      size                 = object.data.size
      count                = object.data.count
      parent_obj_type      = lookup(object.data, "parent_obj_type", null)
      additional_parameters = lookup(object.data, "additional_parameters", {})
    }
  }
}

# Simulate the resources using null_resource
resource "null_resource" "terraform_data" {
  for_each = local.resource_definitions

  # Assign the input values as attributes to simulate resource creation
  triggers = {
    name                 = each.key
    type                 = each.value.type
    size                 = each.value.size
    count                = tostring(each.value.count)
    parent_obj_type      = each.value.parent_obj_type
    additional_parameters = jsonencode(each.value.additional_parameters)
  }
}

# Output for demonstration purposes
output "resources_summary" {
  value = {
    environment_name = var.env,
    resources        = local.resource_definitions
  }
}
