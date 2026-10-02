data "aws_ami" "aws" {
  most_recent = true
  owners      = ["832510228841"]
}

data "aws_ssm_parameter" "private_subnet_a" {
  name = "/${var.project}/${var.env}/public_subnet_a"
}

data "aws_ssm_parameter" "private_subnet_b" {
  name = "/${var.project}/${var.env}/public_subnet_b"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.env}/vpc_id"
}

data "aws_route53_zone" "zone" {
  name         = "bongu.online"
  private_zone = false
}

data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name = "/${var.project}/${var.env}/eks_control_plane_sg_id"
}

data "aws_ssm_parameter" "eks_node_sg_id" {
  name = "/${var.project}/${var.env}/eks_node_sg_id"
}