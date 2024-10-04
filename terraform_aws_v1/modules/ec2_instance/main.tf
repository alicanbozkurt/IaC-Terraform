locals {
  ec2_instances = {
    for obj in var.combined_objects :
    obj.name => obj
    if obj.type == "instance"
  }
}

resource "aws_instance" "instances" {
  for_each = local.ec2_instances

  ami                    = "ami-0c94855ba95c71c99"  # Amazon Linux 2 AMI
  instance_type          = each.value.size == "large" ? "t3.large" : "t3.medium"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = each.value.name
  }
}
