locals {
  rds_databases = {
    for obj in var.combined_objects :
    obj.name => obj
    if (obj.type == "rdb" || obj.type == "nsdb") && obj.db_type != "nosql"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

# Retrieve the secret value
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.db_password_secret_arn
}

resource "aws_db_instance" "databases" {
  for_each = local.rds_databases

  allocated_storage      = 20
  engine                 = each.value.db_type != null ? each.value.db_type : "mysql"
  instance_class         = each.value.size == "large" ? "db.t3.large" : "db.t3.medium"
  db_name                = replace(each.value.name, "-", "_")
  username               = var.db_username
  password               = data.aws_secretsmanager_secret_version.db_password.secret_string
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  #vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = each.value.name
  }
}
