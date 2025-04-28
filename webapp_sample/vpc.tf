data "aws_vpc" "main" {
  id = "vpc-0613b26d4f30241e9"
}

data "aws_subnet" "public_a" {
  id = "subnet-089c14c9c861541eb"
}

data "aws_subnet" "public_c" {
  id = "subnet-0e373fa188267d95a"
}

data "aws_subnet" "public_d" {
  id = "subnet-0d4f15fa2609db77f"
}

data "aws_subnet" "private_a" {
  id = "subnet-0016d7cd884a3932e"
}

data "aws_subnet" "private_c" {
  id = "subnet-0e77dfb8597a88c6f"
}

data "aws_subnet" "private_d" {
  id = "subnet-084f1a2dc49116374"
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
