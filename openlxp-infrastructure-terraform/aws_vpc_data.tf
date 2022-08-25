provider "aws" {
  region                    = var.region
}

data "aws_vpc" "openlxp_vpc" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_route_table" "openlxp_internet_route" {
  filter {
    name = "tag:Name"
    values = [var.vpc_route_table]
  }
}