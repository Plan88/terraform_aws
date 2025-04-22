resource "aws_cloudwatch_log_group" "main" {
  name              = var.service_identifier
  retention_in_days = 1
}

resource "aws_cloudwatch_log_subscription_filter" "main" {
  name            = var.service_identifier
  log_group_name  = aws_cloudwatch_log_group.main.name
  role_arn        = aws_iam_role.logs.arn
  filter_pattern  = "{ $.fields.log_type = \"api\" }"
  destination_arn = aws_kinesis_firehose_delivery_stream.front_api_log.arn
}

resource "aws_cloudwatch_log_stream" "local" {
  name           = "local"
  log_group_name = aws_cloudwatch_log_group.main.name
}

#
# for firehose
#
resource "aws_cloudwatch_log_group" "firehose" {
  name              = "firehose-${var.service_identifier}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_stream" "firehose_error" {
  name           = "error"
  log_group_name = aws_cloudwatch_log_group.firehose.name
}
