resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
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
