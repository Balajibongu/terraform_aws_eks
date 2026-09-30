data "aws_ami" "aws" {
  most_recent = true
  owners      = ["832510228841"]
}

data "aws_ssm_parameter" "public_subnet_a" {
  name = "/${var.project}/${var.env}/public_subnet_a"
}

data "aws_ssm_parameter" "public_subnet_b" {
  name = "/${var.project}/${var.env}/public_subnet_b"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.env}/vpc_id"
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}

data "aws_ssm_parameter" "ingress_alb_sg_id" {
  name = "/${var.project}/${var.env}/ingress_alb_sg_id"
}

data "aws_ssm_parameter" "ingress_alb_arn" {
  name = "/${var.project}/${var.env}/ingress_alb_arn"
}