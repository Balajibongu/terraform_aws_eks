resource "aws_ssm_parameter" "ingress_listener_arn" {
  name  = "/${var.project}/${var.env}/ingress_listener_arn"
  type  = "String"
  value = aws_lb_listener.ingress.arn
}