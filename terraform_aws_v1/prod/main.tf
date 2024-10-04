# Providers
provider "aws" {
  region = "us-east-1"  
}


module "networking" {
  source                     = "../modules/networking"
  env                        = var.env
  vpc_cidr_block             = "10.0.0.0/16"  # Or pass from variables
  public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  allowed_ssh_cidr_blocks    = ["0.0.0.0/0"]  # Replace with your IP range
}

module "terraform_data" {
  source         = "../modules/terraform_data"
  env            = var.env
  objects        = var.objects
  subenv_objects = var.subenv_objects
}

module "ecs_service" {
  source             = "../modules/ecs_service"
  combined_objects   = module.terraform_data.combined_objects
  env                = var.env
  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [module.networking.ecs_security_group_id]
}

# RDS Database Module
module "rds_database" {
  source            = "../modules/rds_database"
  combined_objects  = module.terraform_data.combined_objects
  env               = var.env
  db_username       = var.db_username
  db_password       = aws_secretsmanager_secret_version.db_password.secret_string  # Use the resource attribute directly
  subnet_ids        = module.networking.public_subnet_ids
  security_group_id = module.networking.rds_security_group_id
}


module "ec2_instance" {
  source            = "../modules/ec2_instance"
  combined_objects  = module.terraform_data.combined_objects
  env               = var.env
  subnet_id         = module.networking.public_subnet_ids[0]
  security_group_id = module.networking.ec2_security_group_id
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
}


module "dynamodb_table" {
  source           = "../modules/dynamodb_table"
  combined_objects = module.terraform_data.combined_objects
  env              = var.env
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "/${var.env}/${var.secret_name}"

  tags = {
    Environment = var.env
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}

# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id  = aws_secretsmanager_secret.db_password.id
# }