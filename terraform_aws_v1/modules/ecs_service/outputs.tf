output "service_names" {
  value = [for s in aws_ecs_service.services : s.name]
}
