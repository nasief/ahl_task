# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet pub_sub_ig
resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public-rt"
  }
}

# associate public subnet pub-sub-1a to public route table
resource "aws_route_table_association" "pub-sub_route_table_association" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnet pri-sub-app
resource "aws_subnet" "pri_sub_app" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_app_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri-sub-app"
  }
}

# create private data subnet pri-sub-db
resource "aws_subnet" "pri_sub_db" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri_sub_db_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "pri-sub-db"
  }
}
