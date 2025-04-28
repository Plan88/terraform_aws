resource "aws_security_group" "main" {
  name   = var.service_identifier
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = var.service_identifier
  }
}

resource "aws_security_group_rule" "ingress_from_global" {
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = split(",", data.aws_ssm_parameter.global_ips.value)
}

resource "aws_vpc_security_group_ingress_rule" "self" {
  security_group_id            = aws_security_group.main.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.main.id
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.main.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 0
}
