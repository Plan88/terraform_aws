resource "aws_iam_role" "ecs_task_exec" {
  name               = "ecs-task-exec-${var.service_identifier}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_assume_role.json
}

data "aws_iam_policy_document" "ecs_task_exec_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec" {
  role       = aws_iam_role.ecs_task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
