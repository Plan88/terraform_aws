data "aws_vpc" "main" {
  tags = {
    Name = "vpc1"
  }
}

data "aws_subnet" "public_a" {
  tags = {
    Name = "vpc1-public_a"
  }
}

data "aws_subnet" "public_c" {
  tags = {
    Name = "vpc1-public_c"
  }
}

data "aws_subnet" "public_d" {
  tags = {
    Name = "vpc1-public_d"
  }
}

data "aws_subnet" "private_a" {
  tags = {
    Name = "vpc1-private_a"
  }
}

data "aws_subnet" "private_c" {
  tags = {
    Name = "vpc1-private_c"
  }
}

data "aws_subnet" "private_d" {
  tags = {
    Name = "vpc1-private_d"
  }
}

locals {
  public_subnet_ids = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_c.id,
    data.aws_subnet.public_d.id
  ]
  private_subnet_ids = [
    data.aws_subnet.private_a.id,
    data.aws_subnet.private_c.id,
    data.aws_subnet.private_d.id
  ]
}
