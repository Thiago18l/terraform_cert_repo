data "aws_availability_zones" "azs" {}


resource "aws_vpc" "votation_vpc" {
  cidr_block = "192.168.0.0/22"

  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}

resource "aws_subnet" "az1_private_subnet" {
  vpc_id                  = aws_vpc.votation_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.azs.names, 0)
  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}

resource "aws_subnet" "az2_private_subnet" {
  vpc_id                  = aws_vpc.votation_vpc.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.azs.names, 1)
  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}

resource "aws_security_group" "alb_security_gp" {
  name = "sec_gp_votation"
  #outbound
  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Connection with urn"
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }]

  #inbound
  ingress = [{
    cidr_blocks = ["${aws_vpc.votation_vpc.cidr_block}"]
    description = "Connection with urns"
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }]

  tags = {
    "project_votation" = "${local.votation_tag}"
  }
}