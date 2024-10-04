# Local variable to filter RDS databases to create
locals {
  rds_databases = {
    for obj in var.combined_objects :
    obj.name => obj
    if (obj.type == "rdb" || obj.type == "nsdb") && obj.db_type != "nosql"
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

# Remove the data source for the secret value since we are passing db_password as a variable

# Create RDS instances
resource "aws_db_instance" "databases" {
  for_each = local.rds_databases

  allocated_storage      = 20
  engine                 = each.value.db_type != null ? each.value.db_type : "mysql"
  instance_class         = each.value.size == "large" ? "db.t3.large" : "db.t3.medium"
  db_name                = replace(each.value.name, "-", "_")  # Replace hyphens to meet RDS naming constraints
  username               = var.db_username
  password               = var.db_password  # Use the password passed from the root module
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.security_group_id]  # Ensure this variable is passed from the root module

  tags = {
    Name = each.value.name
  }
}
