locals {
  ec2_instances = {
    for obj in var.combined_objects :
    obj.name => obj
    if obj.type == "instance"
  }
}

resource "aws_instance" "instances" {
  for_each = local.ec2_instances

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = each.value.name
  }
}
