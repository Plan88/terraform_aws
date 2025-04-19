resource "aws_s3_bucket" "tfstate" {
  bucket = "terraform-tfstate-plan8"

  lifecycle {
    prevent_destroy = true
  }
}
