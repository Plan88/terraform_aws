resource "aws_cloudwatch_log_group" "main" {
  name              = var.service_identifier
  retention_in_days = 1
}

resource "aws_cloudwatch_log_stream" "local" {
  name           = "local"
  log_group_name = aws_cloudwatch_log_group.main.name
}
