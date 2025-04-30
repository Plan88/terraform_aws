variable "github_terraform_aws_url" {
  type        = string
  description = "terraform_aws のリポジトリの URL"
}

variable "region" {
  type        = string
  default     = "ap-northeast-1"
  description = "リージョン"
}
