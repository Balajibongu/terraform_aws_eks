resource "aws_ssm_parameter" "ingress_alb_arn" {
  name  = "/${var.project}/${var.env}/ingress_alb_arn"
  type  = "String"
  value = aws_acm_certificate.roboshop.arn
}