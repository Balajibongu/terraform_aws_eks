resource "aws_ecr_repository" "catalogue" {
  name                 = "${var.project}-${var.env}/Catalogue"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}
