variable "ecs_cluster" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "task_family" {
  description = "The ECS task definition family name."
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "app_name" {
  description = "The name of the application container."
  type        = string
}

variable "container_image" {
  description = "The URI of the Docker image to use in the ECS task."
  type        = string
}

variable "container_port" {
  description = "The port number exposed by the container."
  type        = number
}

variable "tg_http_arn" {
  description = "The ARN of the HTTP target group for the load balancer."
  type        = string
}

variable "tg_https_arn" {
  description = "The ARN of the HTTPS target group for the load balancer."
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnet IDs for the ECS service."
  type        = list(string)
}

variable "ecs_sg" {
  description = "The security group(s) attached to ECS tasks."
  type        = string
}
