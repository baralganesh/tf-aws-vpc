resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my-public-route-table"
  }
}

resource "aws_route_table_association" "my_public_route_table_association" {
  count = length(aws_subnet.my_public_subnet)

  subnet_id      = aws_subnet.my_public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }

  tags = {
    Name = "my-private-route-table"
  }
}

resource "aws_route_table_association" "my_private_route_table_association" {
  count = length(aws_subnet.my_private_subnet)

  subnet_id      = aws_subnet.my_private_subnet[count.index].id
  route_table_id = aws_route_table.my_private_route_table.id
}