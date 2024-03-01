resource "aws_eip" "my_nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.my_public_subnet[0].id

  tags = {
    Name = "my-nat-gw"
  }
}