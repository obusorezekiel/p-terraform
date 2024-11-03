output "lb_security_group_id" {
  description = "The ID of the Load Balancer security group."
  value       = aws_security_group.complex_lb_sg.id
}


output "backend_security_group_id" {
  description = "The ID of the Backend application security group."
  value       = aws_security_group.complex_backend_ecs_sg.id
}


output "rds_security_group_id" {
  description = "The ID of the RDS security group."
  value       = [aws_security_group.complex_rds_sg.id]
}