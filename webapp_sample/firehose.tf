resource "aws_kinesis_firehose_delivery_stream" "front_api_log" {
  name        = var.service_identifier
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = data.aws_s3_bucket.log.arn

    buffering_size     = 64
    buffering_interval = 60

    dynamic_partitioning_configuration {
      enabled = true
    }

    custom_time_zone    = "Asia/Tokyo"
    prefix              = "webapp_sample/front_api_log/!{partitionKeyFromLambda:year}/!{partitionKeyFromLambda:month}/!{partitionKeyFromLambda:day}/!{partitionKeyFromLambda:hour}/"
    error_output_prefix = "webapp_sample/front_api_log_error/!{timestamp:yyyy/MM/dd/HH}/!{firehose:error-output-type}/"


    processing_configuration {
      enabled = true

      processors {
        type = "Decompression"
      }

      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.log_transform.arn}:$LATEST"
        }
      }
    }

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.firehose.name
      log_stream_name = aws_cloudwatch_log_stream.firehose_error.name
    }
  }
}
