# resource "aws_ecr_repository" "this" {
#   name                 = "django-app"
#   image_tag_mutability = "MUTABLE"

#   tags = {
#     Name      = "django-app"
#     Terraform = "Yes"
#   }
# }