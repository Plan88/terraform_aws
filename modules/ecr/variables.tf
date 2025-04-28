variable "repository_name" {
  type        = string
  description = "リポジトリ名"
}

variable "expiration_days" {
  type        = number
  description = "untagged のイメージについて push されてから何日間経過したら削除するか"
  default     = 1
}
