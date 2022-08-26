data "aws_availability_zones" "azs" {}
data "aws_subnets" "name" {

}


resource "aws_vpc" "cassandra_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags {
    name = "cassandra network"
  }
}

resource "aws_subnet" "az1_private_subnet" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.azs.names, 0)
  tags = {
    Name = "${local.network_tag}"
  }
}

resource "aws_subnet" "az2_private_subnet" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.azs.names, 1)

  tags = {
    Name = "${local.network_tag}"
  }
}

resource "aws_subnet" "az3_private_subnet" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.azs.names, 2)

  tags = {
    Name = "${local.network_tag}"
  }
}

resource "aws_subnet" "az1_subnet_public" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.4.0/28"
  availability_zone       = element(data.aws_availability_zones.azs.names, 0)
  map_public_ip_on_launch = "true"

  tags {
    Name = local.network_tag
  }
}

resource "aws_subnet" "az2_subnet_public" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.4.16/28"
  availability_zone       = element(data.aws_availability_zones.azs.names, 1)
  map_public_ip_on_launch = "true"

  tags {
    Name = local.network_tag
  }
}

resource "aws_subnet" "az3_subnet_public" {
  vpc_id                  = aws_vpc.cassandra_vpc.id
  cidr_block              = "10.0.4.32/28"
  availability_zone       = element(data.aws_availability_zones.azs.names, 2)
  map_public_ip_on_launch = "true"

  tags {
    Name = local.network_tag
  }
}



# Tables for private subnets

resource "aws_route_table" "route_az1" {
  vpc_id = aws_vpc.cassandra_vpc.id
  route = [ {
    carrier_gateway_id = "value"
    cidr_block = "value"
    core_network_arn = "value"
    destination_prefix_list_id = "value"
    egress_only_gateway_id = "value"
    gateway_id = "value"
    instance_id = "value"
    ipv6_cidr_block = "value"
    local_gateway_id = "value"
    nat_gateway_id = "value"
    network_interface_id = "value"
    transit_gateway_id = "value"
    vpc_endpoint_id = "value"
    vpc_peering_connection_id = "value"
  } ]
}




resource "aws_route_table" "route_tbl" {
  vpc_id = aws_vpc.cassandra_vpc.id
  route = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gtw_cassandra.id}"
  }]
}

resource "aws_network_acl" "acl_net" {
  vpc_id     = aws_vpc.cassandra_vpc.id
  subnet_ids = ["${aws_subnet.main.id}"]
  egress = [{
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    rule_no    = 100
    to_port    = 0
  }]

  ingress = [{
    protocol   = "all"
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = 0
  }]

  tags = {
    "Name" = "${var.user_name}"
  }
}

resource "aws_security_group" "internet_access" {
  name   = "allow internet access"
  vpc_id = aws_vpc.cassandra_vpc.id
  tags = {
    "Name" = "cluster_internet"
  }
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_connect" {
  name   = "connection via ssh"
  vpc_id = aws_vpc.cassandra_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [""]
  }
}
# https://github.com/BohdanKalytka/cassandratraining/blob/master/terraform/vpc.tf