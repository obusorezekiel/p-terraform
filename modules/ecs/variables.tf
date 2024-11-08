# ECS Cluster Name - The name of the ECS cluster where services will be deployed
variable "ecs_cluster" {
  description = "The name of the ECS cluster."
  type        = string
}

# ECS Task Definition Family Name - The family name for ECS task definitions, used to group similar tasks
variable "task_family" {
  description = "The ECS task definition family name."
  type        = string
}

# Environment - The environment in which the ECS service will run (e.g., dev, prod)
variable "environment" {
  description = "The environment for the resources"
  type        = string
}

# Application Name - The name of the containerized application to be deployed in ECS
variable "app_name" {
  description = "The name of the application container."
  type        = string
}

# Container Image URI - The URI for the Docker image to use in the ECS task (e.g., ECR or Docker Hub URL)
variable "container_image" {
  description = "The URI of the Docker image to use in the ECS task."
  type        = string
}

# Container Port - The port exposed by the container to communicate with the outside world
variable "container_port" {
  description = "The port number exposed by the container."
  type        = number
}

# HTTP Target Group ARN - The ARN of the HTTP target group used by the load balancer for routing traffic
variable "tg_http_arn" {
  description = "The ARN of the HTTP target group for the load balancer."
  type        = string
}

# HTTPS Target Group ARN - The ARN of the HTTPS target group used by the load balancer for routing traffic
variable "tg_https_arn" {
  description = "The ARN of the HTTPS target group for the load balancer."
  type        = string
}

# Private Subnets - The list of private subnets for running ECS tasks (for Fargate tasks)
variable "private_subnets" {
  description = "A list of private subnet IDs for the ECS service."
  type        = list(string)
}

# ECS Security Group - The security group(s) attached to the ECS tasks, controlling network access
variable "ecs_sg" {
  description = "The security group(s) attached to ECS tasks."
  type        = string
}
