resource "aws_security_group" "vpce" {
  name   = "vpce"
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-vpce"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpce_https" {
  security_group_id = aws_security_group.vpce.id
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.vpc1.cidr_block
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "vpce" {
  security_group_id = aws_security_group.vpce.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
