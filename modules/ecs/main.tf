resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster

  tags = {
    Name        = "${var.ecs_cluster}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.task_family}-${var.environment}"

  container_definitions = jsonencode([
  {
    name         = var.app_name,
    image        = var.container_image,
    essential    = true,
    portMappings = [
      {
        containerPort = var.container_port,
        hostPort      = var.container_port
      }
    ],
    memory       = 512,
    cpu          = 256
  }
])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512    
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = var.tg_http_arn
    container_name   = var.app_name
    container_port   = var.container_port
  }

  load_balancer {
    target_group_arn = var.tg_https_arn
    container_name   = var.app_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg]
  }

  tags = {
    Name        = "${var.app_name}-service-${var.environment}"
    Environment = var.environment
  }
}
