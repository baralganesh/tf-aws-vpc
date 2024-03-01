# Make sure subnets created accross avaliability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# Public sunets
resource "aws_subnet" "my_public_subnet" {
  count = 6

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-public-subnet-${count.index}"
  }
}


# Private subnets
resource "aws_subnet" "my_private_subnet" {
  count = 6

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 3)
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-private-subnet-${count.index}"
  }
}
