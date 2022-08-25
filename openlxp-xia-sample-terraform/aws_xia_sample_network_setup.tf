##############################################################
# AWS NETWORK CONFIG FOR EXPERIENCE INDEX AGENTS (XIA SAMPLE)
##############################################################
###############################################
# XIA SAMPLE SUBNET/ROUTE TABLE CONFIGURATION
###############################################
#######################
# XIA SAMPLE SUBNET 1
#######################
resource "aws_subnet" "xia_sample_subnet1_useast1" {
  provider                          = aws
  availability_zone                 = element(data.aws_availability_zones.openlxp-azs.names, 0)
  vpc_id                            = aws_vpc.openlxp_ecc_vpc.id
  cidr_block                        = local.xia.sample.subnet1_cidr_block
  map_public_ip_on_launch           = true
  tags = {
    Name                            = local.xia.sample.subnet1_name
  }
}

#####################
# XIA_SAMPLE ROUTE
# TABLE ASSOCIATION
#####################
resource "aws_route_table_association" "xia-sample_public_route1" {
  subnet_id                         = aws_subnet.xia_sample_subnet1_useast1.id
  route_table_id                    = aws_route_table.openlxp_internet_route.id
}
