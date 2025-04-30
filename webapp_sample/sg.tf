resource "aws_security_group" "alb" {
  name   = "alb-${var.service_identifier}"
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "alb-${var.service_identifier}"
  }
}

resource "aws_security_group_rule" "alb_allow_from_local" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = split(",", data.aws_ssm_parameter.global_ips.value)
}

resource "aws_vpc_security_group_egress_rule" "alb_allow_egress" {
  security_group_id = aws_security_group.alb.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "ecs" {
  name   = "ecs-${var.service_identifier}"
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "ecs-${var.service_identifier}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_allow_from_alb" {
  security_group_id            = aws_security_group.ecs.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "ecs_allow_egress" {
  security_group_id = aws_security_group.ecs.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
