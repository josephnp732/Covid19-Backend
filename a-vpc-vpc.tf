#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "covid19" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
      "Name", "terraform-eks-covid19-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "covid19" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.covid19.id}"

  tags = "${
    map(
      "Name", "terraform-eks-covid19-node",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "covid19" {
  vpc_id = "${aws_vpc.covid19.id}"

  tags = {
    Name = "terraform-eks-covid19"
  }
}

resource "aws_route_table" "covid19" {
  vpc_id = "${aws_vpc.covid19.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.covid19.id}"
  }
}

resource "aws_route_table_association" "covid19" {
  count = 2

  subnet_id      = "${aws_subnet.covid19.*.id[count.index]}"
  route_table_id = "${aws_route_table.covid19.id}"
}
