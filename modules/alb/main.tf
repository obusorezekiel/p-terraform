# Load Balancer
resource "aws_lb" "complex_lb" {
  name            = "complex-lb"
  security_groups = [var.lb_sg]
  subnets         = var.public_subnets
  idle_timeout    = 400

  tags = {
    Name        = "complex-lb-${var.environment}"
    Environment = var.environment
  }
}

# HTTP Target Group
resource "aws_lb_target_group" "complex_http_tg" {
  name         = "complex-lb-http-tg-${substr(uuid(), 0, 8)}"
  port         = var.tg_http_port
  protocol     = var.tg_http_protocol
  vpc_id       = var.vpc_id
  target_type  = "ip"

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }

  tags = {
    Name        = "complex-http-tg-${var.environment}"
    Environment = var.environment
  }
}

# HTTPS Target Group
resource "aws_lb_target_group" "complex_https_tg" {
  name         = "complex-lb-https-tg-${substr(uuid(), 0, 8)}"
  port         = var.tg_https_port
  protocol     = var.tg_https_protocol
  vpc_id       = var.vpc_id
  target_type  = "ip"

  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }

  tags = {
    Name        = "complex-https-tg-${var.environment}"
    Environment = var.environment
  }
}

# HTTP Listener
resource "aws_lb_listener" "complex_lb_http_listener" {
  load_balancer_arn = aws_lb.complex_lb.arn
  port              = var.listener_http_port
  protocol          = var.listener_http_protocol

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name        = "http-listener-${var.environment}"
    Environment = var.environment
  }
}

# HTTPS Listener
resource "aws_lb_listener" "complex_lb_https_listener" {
  load_balancer_arn = aws_lb.complex_lb.arn
  port              = var.listener_https_port
  protocol          = "HTTPS"                    
  ssl_policy        = "ELBSecurityPolicy-2016-08"  
  certificate_arn   = var.certificate_arn         

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.complex_https_tg.arn
  }

  tags = {
    Name        = "https-listener-${var.environment}"
    Environment = var.environment
  }
}
