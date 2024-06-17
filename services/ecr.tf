resource "aws_ecr_repository" "vb_images" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    "project" = "curaboard"
  }
}