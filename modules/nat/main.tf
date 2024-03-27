# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub
resource "aws_eip" "eip-nat-a" {
  vpc = true
  tags = {
    Name = "eip-nat-a"
  }
}

# create nat gateway in public subnet pub-sub-1a
resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = var.pub_sub_id

  tags = {
    Name = "nat-a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.igw_id]
}

# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "pri-rt-a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-a.id
  }

  tags = {
    Name = "Pri-rt-a"
  }
}

# associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-3a-with-Pri-rt-a" {
  subnet_id      = var.pri_sub_app_id
  route_table_id = aws_route_table.pri-rt-a.id
}

# associate private subnet pri-sub-4b with private route table Pri-rt-b
resource "aws_route_table_association" "pri-sub-4b-with-Pri-rt-b" {
  subnet_id      = var.pri_sub_db_id
  route_table_id = aws_route_table.pri-rt-a.id
}
