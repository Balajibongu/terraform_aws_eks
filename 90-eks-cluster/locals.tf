locals {
  ami              = data.aws_ami.aws.id
  eks_control_plane= data.aws_ssm_parameter.eks_control_plane_sg_id.value
  eks_node=data.aws_ssm_parameter.eks_node_sg_id.value
  vpc_id=data.aws_ssm_parameter.vpc_id.value
   subnet=[
    data.aws_ssm_parameter.private_subnet_a.value,
    data.aws_ssm_parameter.private_subnet_b.value
    ]
  common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}