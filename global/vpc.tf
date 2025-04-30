resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc1"
  }
}

locals {
  public_subnet1_settings = {
    public_a = {
      cidr              = "10.0.0.0/24"
      availability_zone = "ap-northeast-1a"
    }
    public_c = {
      cidr              = "10.0.1.0/24"
      availability_zone = "ap-northeast-1c"
    }
    public_d = {
      cidr              = "10.0.2.0/24"
      availability_zone = "ap-northeast-1d"
    }
  }

  private_subnet1_settings = {
    private_a = {
      cidr              = "10.0.10.0/24"
      availability_zone = "ap-northeast-1a"
    }
    private_c = {
      cidr              = "10.0.11.0/24"
      availability_zone = "ap-northeast-1c"
    }
    private_d = {
      cidr              = "10.0.12.0/24"
      availability_zone = "ap-northeast-1d"
    }
  }
}

resource "aws_subnet" "subnet1" {
  for_each          = merge(local.public_subnet1_settings, local.private_subnet1_settings)
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.availability_zone
  tags = {
    Name = "vpc1-${each.key}"
  }
}

locals {
  private_subnet_ids = [for key in keys(local.private_subnet1_settings) : aws_subnet.subnet1[key].id]
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-igw"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "vpc1-rt"
  }
}

resource "aws_route_table_association" "rt1_association" {
  for_each       = local.public_subnet1_settings
  subnet_id      = aws_subnet.subnet1[each.key].id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.vpc1.id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = {
    Name = "ecr.api"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.vpc1.id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = {
    Name = "ecr.dkr"
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.vpc1.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.vpce.id]
  private_dns_enabled = true

  tags = {
    Name = "logs"
  }
}

resource "aws_route_table" "vpce_gateway" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-private-rt"
  }
}

resource "aws_route_table_association" "rt1_private" {
  for_each       = toset(local.private_subnet_ids)
  subnet_id      = each.key
  route_table_id = aws_route_table.vpce_gateway.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc1.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.vpce_gateway.id]

  tags = {
    Name = "vpc1-vpce-s3"
  }
}
