# 手動で管理
data "aws_ssm_parameter" "global_ips" {
  name = "/local/global-ips"
}
