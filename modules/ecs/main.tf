# ECS Cluster - Create an ECS cluster for hosting the services

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster

  tags = {
    Name        = "${var.ecs_cluster}-${var.environment}"
    Environment = var.environment
  }
}

# ECS Task Definition - Define the task (container) configuration for ECS
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

# ECS Task Execution Role - IAM role granting ECS the permissions to manage tasks
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# Assume Role Policy Document - Define the trust relationship for ECS tasks
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# IAM Role Policy Attachment - Attach the ECS task execution policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Service - Define the ECS service that will run the tasks in the ECS cluster
resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-service-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  # Load Balancer Configuration - Configure the ECS service to use a load balancer
  load_balancer {
    target_group_arn = var.tg_https_arn
    container_name   = var.app_name
    container_port   = var.container_port
  }

# Network Configuration - Configure network settings for the ECS service
  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.ecs_sg]
  }

  tags = {
    Name        = "${var.app_name}-service-${var.environment}"
    Environment = var.environment
  }
}
