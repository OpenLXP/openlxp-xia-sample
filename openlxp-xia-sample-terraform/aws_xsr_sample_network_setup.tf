
resource "aws_subnet" "xsr_sample_subnet1_useast1" {
  provider                          = aws
  availability_zone                 = element(data.aws_availability_zones.openlxp-azs.names, 0)
  vpc_id                            = aws_vpc.openlxp_ecc_vpc.id
  cidr_block                        = local.xsr_sample.subnet1_cidr_block
  map_public_ip_on_launch           = true
  tags = {
    Name                            = local.xsr_sample.subnet1_name
  }
}

#####################
# XIA_MOODLE ROUTE
# TABLE ASSOCIATION
#####################
resource "aws_route_table_association" "xsr_sample_public_route1" {
  subnet_id                         = aws_subnet.xsr_sample_subnet1_useast1.id
  route_table_id                    = aws_route_table.openlxp_internet_route.id
}
