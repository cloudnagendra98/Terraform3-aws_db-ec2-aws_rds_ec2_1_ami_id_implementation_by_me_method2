resource "aws_vpc" "ntier_vpc" {
  cidr_block = var.vpc_cidr_range
  tags = {
    Name = local.name
  }

}

resource "aws_subnet" "subnets" {
  count             = length(var.subnet_tags)
  availability_zone = var.subnet_azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr_range, 8, count.index)
  vpc_id            = aws_vpc.ntier_vpc.id

  tags = {
    Name = var.subnet_tags[count.index]
  }

  depends_on = [
    aws_vpc.ntier_vpc
  ]
}



data "aws_route_table" "default_rtb" {

  vpc_id = aws_vpc.ntier_vpc.id

  depends_on = [
    aws_subnet.subnets,
    aws_vpc.ntier_vpc
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ntier_vpc.id

  depends_on = [
    aws_subnet.subnets,
  aws_vpc.ntier_vpc]
}

resource "aws_route" "route" {
  route_table_id         = data.aws_route_table.default_rtb.id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [
    data.aws_route_table.default_rtb,
  aws_internet_gateway.igw]


}