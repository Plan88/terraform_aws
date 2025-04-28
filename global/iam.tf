resource "aws_iam_role" "github_actions_codebuild" {
  name               = "github-actions-codebuild"
  assume_role_policy = data.aws_iam_policy_document.github_actions_codebuild_assume_role.json
}

data "aws_iam_policy_document" "github_actions_codebuild_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_codebuild" {
  role       = aws_iam_role.github_actions_codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
