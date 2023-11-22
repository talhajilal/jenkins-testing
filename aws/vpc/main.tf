  locals {
  vpc_id = try(aws_vpc_ipv4_cidr_block_association.this[0].vpc_id, aws_vpc.this[0].id, "")
  create_vpc = var.create_vpc
}
resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}"
  }
}


resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = local.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0

  # Do not turn this into `local.vpc_id`
  vpc_id = aws_vpc.this[0].id

  cidr_block = element(var.secondary_cidr_blocks, count.index)
}

resource "aws_subnet" "public_subnet_us-east_1a" {
  vpc_id                                         = local.vpc_id
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.az-region}"
  tags = {
    Name = "Subnet az 1a"
  }
}

resource "aws_subnet" "private_1_subnet_us-east_1a" {
  vpc_id                                         = local.vpc_id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "${var.az-region}"
  tags = {
    Name = "Subnet private 1 az 1a"
  }
}

resource "aws_subnet" "private_2_subnet_us-east_1a" {
  vpc_id                                         = local.vpc_id
  cidr_block        = "172.31.3.0/24"
  availability_zone = "${var.az-region}"
  tags = {
    Name = "Subnet private 2 az 1a"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id                                         = local.vpc_id
  tags = {
    Name = "InternetGateway"
  }
}
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.this[0].main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}


resource "aws_eip" "zaftech_eip" {
  # vpc        = true
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.zaftech_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet_us-east_1a.id}"
  depends_on    = [aws_internet_gateway.gw]
}


resource "aws_route_table" "private_route_table" {
  vpc_id = local.vpc_id

  tags = {
    Name = "Private route table"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}


# Associate subnet public_subnet_us-east_1a to public route table
resource "aws_route_table_association" "public_subnet_us-east_1a_association" {
  subnet_id      = "${aws_subnet.public_subnet_us-east_1a.id}"
  route_table_id = "${aws_vpc.this[0].main_route_table_id}"
}

# Associate subnet private_1_subnet_us-east_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_us-east_1a_association" {
  subnet_id      = "${aws_subnet.private_1_subnet_us-east_1a.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

# Associate subnet private_2_subnet_us-east_1a to private route table
resource "aws_route_table_association" "pr_2_subnet_us-east_1a_association" {
  subnet_id      = "${aws_subnet.private_2_subnet_us-east_1a.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}