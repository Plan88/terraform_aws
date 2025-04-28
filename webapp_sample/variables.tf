variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "service_identifier" {
  type = string
}

variable "global_access_ips" {
  type    = list(string)
  default = []
}
