locals {
  dynamodb_tables = {
    for obj in var.combined_objects :
    obj.name => obj
    if obj.db_type == "nosql"
  }
}

resource "aws_dynamodb_table" "tables" {
  for_each = local.dynamodb_tables

  name           = each.value.name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = var.env
    Name        = each.value.name
  }
}
