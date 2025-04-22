resource "aws_lambda_function" "log_transform" {
  function_name = "log-transform-${var.service_identifier}"
  role          = aws_iam_role.lambda.arn
  handler       = "log_transform.front_api_log_handler"
  filename      = data.archive_file.dummy.output_path

  runtime = "python3.13"

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.firehose.name
  }

  lifecycle {
    ignore_changes = [filename]
  }
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/dummy.zip"

  source {
    content  = "dummy"
    filename = "log_transform.py"
  }

  depends_on = [null_resource.for_dummy]
}

resource "null_resource" "for_dummy" {}
