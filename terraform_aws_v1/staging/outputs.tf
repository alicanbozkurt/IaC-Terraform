output "object_names" {
  value = [for obj in module.terraform_data.combined_objects : obj.name]
}

output "ecs_service_names" {
  value = module.ecs_service.service_names
}

output "rds_database_endpoints" {
  value = module.rds_database.endpoints
}

output "ec2_instance_ids" {
  value = module.ec2_instance.instance_ids
}

# Outputs
output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}