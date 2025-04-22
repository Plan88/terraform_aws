data "aws_s3_bucket" "tfstate" {
  bucket = "terraform-tfstate-plan8"
}

data "aws_s3_bucket" "log" {
  bucket = "log-plan8"
}
