resource "aws_ecr_repository" "ecr" {
  name                 = "roboshop/${var.image}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}
