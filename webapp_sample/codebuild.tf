resource "aws_codebuild_project" "github_actions" {
  name         = "webapp_sample_rs"
  service_role = data.aws_iam_role.github_actions_codebuild.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    type         = "LINUX_CONTAINER"
    image        = "aws/codebuild/standard:5.0"
  }

  source {
    type     = "GITHUB"
    location = var.github_webapp_sample_rs_url
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
}

resource "aws_codebuild_webhook" "github_actions" {
  project_name = aws_codebuild_project.github_actions.name
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "WORKFLOW_JOB_QUEUED"
    }
  }
}
