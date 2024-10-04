output "endpoints" {
  value = [for db in aws_db_instance.databases : db.endpoint]
}
