resource "aws_s3_bucket" "tfstate" {
  bucket = "terraform-tfstate-plan8"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "log" {
  bucket = "log-plan8"
}

resource "aws_s3_bucket_lifecycle_configuration" "log" {
  bucket = aws_s3_bucket.log.id
  rule {
    id     = "expiration"
    status = "Enabled"
    expiration {
      days = 7
    }
    filter {
      prefix = ""
    }
  }
}
