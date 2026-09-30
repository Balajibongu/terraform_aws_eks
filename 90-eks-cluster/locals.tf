locals {
  ami              = data.aws_ami.aws.id
  ingress= data.aws_ssm_parameter.ingress_alb_sg_id.value
  ingress_arn=data.aws_ssm_parameter.ingress_alb_arn.value
   subnet=[
    data.aws_ssm_parameter.public_subnet_a.value,
    data.aws_ssm_parameter.public_subnet_b.value
    ]
  common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}