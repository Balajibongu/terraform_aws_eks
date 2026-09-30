locals {
  ami              = data.aws_ami.aws.id
  common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}