resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "abhishek-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.public_subnet_cidr_a
  availability_zone         = "${var.aws_region}a"
  map_public_ip_on_launch   = true
  tags = {
    Name = "abhishek-public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.public_subnet_cidr_b
  availability_zone         = "${var.aws_region}b"
  map_public_ip_on_launch   = true
  tags = {
    Name = "abhishek-public-subnet-b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_subnet_cidr_a
  availability_zone         = "${var.aws_region}a"
  tags = {
    Name = "abhishek-private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_subnet_cidr_b
  availability_zone         = "${var.aws_region}b"
  tags = {
    Name = "abhishek-private-subnet-b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "abhishek-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "abhishek-public-route-table"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}