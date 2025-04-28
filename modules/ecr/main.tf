resource "aws_ecr_repository" "main" {
  name = var.repository_name
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than ${var.expiration_days} days"
        selection = {
          tasStatus  = "untagged"
          countType  = "sinceImagePushed"
          countUnit  = "days"
          countNumer = var.expiration_days
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
