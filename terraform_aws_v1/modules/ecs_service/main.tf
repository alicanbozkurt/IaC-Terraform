locals {
  ecs_services = {
    for obj in var.combined_objects :
    obj.name => obj
    if obj.type == "kcls"
  }

  unique_subenvs = distinct([for obj in local.ecs_services : obj.subenv if obj.subenv != null])
}

# Create ECS clusters per unique sub-environment
resource "aws_ecs_cluster" "clusters" {
  for_each = {
    for subenv in local.unique_subenvs :
    subenv => subenv
  }

  name = "${var.env}-${each.key}-cluster"
}

# Create ECS task definitions
resource "aws_ecs_task_definition" "tasks" {
  for_each = local.ecs_services

  family                   = each.value.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.size == "large" ? "1024" : "512"
  memory                   = each.value.mem != null ? each.value.mem : "2048"

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "nginx"  
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

# Create ECS services
resource "aws_ecs_service" "services" {
  for_each = local.ecs_services

  name            = each.value.name
  cluster         = aws_ecs_cluster.clusters[each.value.subenv].id
  task_definition = aws_ecs_task_definition.tasks[each.key].arn
  desired_count   = each.value.count  

  launch_type = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.tasks]
}
