resource "aws_internet_gateway" "gtw_cassandra" {
  vpc_id = aws_vpc.cassandra_vpc
  tags = {
    Name = "${var.cluster_name}"
  }
}

