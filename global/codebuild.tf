resource "aws_codebuild_project" "github_actions_terraform_aws" {
  name         = "terraform_aws"
  service_role = aws_iam_role.github_actions_codebuild.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/standard:5.0"
  }

  source {
    type     = "GITHUB"
    location = var.github_terraform_aws_url
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
}
