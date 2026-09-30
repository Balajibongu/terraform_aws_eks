resource "aws_lb" "ingress" {
  name               = "ingress-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.ingress]
  subnets            = local.subnet

  enable_deletion_protection = false

  tags = merge(
    var.ingress_alb_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-ingress_lb"
    }
  )
}

resource "aws_lb_listener" "ingress" {
  load_balancer_arn = aws_lb.ingress.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
  certificate_arn   = local.ingress_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1>fixed responce</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "ingress" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "roboshop-${var.env}.${var.domain_name}"
  type    = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.ingress.dns_name
    zone_id                = aws_lb.ingress.zone_id
    evaluate_target_health = true
  }
}
