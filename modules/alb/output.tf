# Output the ARN of the Load Balancer
output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.complex_lb.arn
}

# Output the DNS name of the Load Balancer
output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.complex_lb.dns_name
}

# Output the HTTP Target Group ARN
output "http_target_group_arn" {
  description = "ARN of the HTTP target group"
  value       = aws_lb_target_group.complex_http_tg.arn
}

# Output the HTTPS Target Group ARN
output "https_target_group_arn" {
  description = "ARN of the HTTPS target group"
  value       = aws_lb_target_group.complex_https_tg.arn
}

# Output the HTTP Listener ARN
output "http_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.complex_lb_http_listener.arn
}

# Output the HTTPS Listener ARN
output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = aws_lb_listener.complex_lb_https_listener.arn
}

# Output the HTTPS Certificate ARN
output "https_certificate_arn" {
  description = "ARN of the ACM SSL certificate"
  value       = var.certificate_arn
}
