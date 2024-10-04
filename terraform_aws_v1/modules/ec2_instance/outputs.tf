output "instance_ids" {
  value = [for id in aws_instance.instances : id.id]
}
