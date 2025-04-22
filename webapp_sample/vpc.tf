data "aws_vpc" "main" {
  id = "vpc-0c0ecc50ea0bf47c3"
}

data "aws_subnet" "public_a" {
  id = "subnet-0c9f5f5463d6fc2da"
}

data "aws_subnet" "public_c" {
  id = "subnet-08827c42d7006c323"
}

data "aws_subnet" "public_d" {
  id = "subnet-0ff7d309c610bfc35"
}

data "aws_subnet" "private_a" {
  id = "subnet-0c04e3e2956310b3e"
}

data "aws_subnet" "private_c" {
  id = "subnet-04414409bbe7e9630"
}

data "aws_subnet" "private_d" {
  id = "subnet-0c994265d448e9fdd"
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
