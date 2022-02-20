resource "aws_vpc" "k8s_private_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
      tomap({a = "Name", b = "k8s_private_vpc"}),
      tomap({a = "kubernetes.io/cluster/${local.cluster_name}", b = "shared"}),
      var.tags
  )
}

resource "aws_internet_gateway" "k8s_internet_gateway" {
  vpc_id = aws_vpc.k8s_private_vpc.id

  tags = merge(
    tomap({a = "Name", b = "k8s_internet_gateway"}),
      var.tags
  )
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "k8s-eks-subnet" {
  count = 3
  vpc_id                  = aws_vpc.k8s_private_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.k8s_private_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = false

  tags = merge(
      tomap({a = "Name", b = "k8s-eks-subnet"}),
      tomap({a = "kubernetes.io/cluster/${local.cluster_name}", b = "shared"}),
      var.tags
  )
}

resource "aws_route_table" "k8s_route_table" {
  vpc_id = aws_vpc.k8s_private_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_internet_gateway.id
  }

  tags = merge(
      tomap({a = "Name", b = "k8s-route-table"}),
      var.tags
    )
}

resource "aws_route" "k8s_route_routetointernet" {
  route_table_id            = aws_route_table.k8s_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.k8s_internet_gateway.id
}

resource "aws_route_table_association" "k8s_route_table_associacion" {
  subnet_id      = aws_subnet.k8s-eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.k8s_route_table.id
  count          = 3
}