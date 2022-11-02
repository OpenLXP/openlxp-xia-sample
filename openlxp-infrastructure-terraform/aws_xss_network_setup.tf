###########################################################
# AWS NETWORK CONFIG FOR EXPERIENCE SCHEMA SERVICE (XSS)
###########################################################
##################################
# subnet1 in us-east-1
##################################
resource "aws_subnet" "xss_subnet1_useast1" {
  provider                          = aws
  availability_zone                 = local.vpc.vpc_AZ
  vpc_id                            = data.aws_vpc.openlxp_vpc.id
  cidr_block                        = local.xss.subnet1_cidr_block
  map_public_ip_on_launch           = true
  tags = {
    Name                            = local.xss.subnet1_name
  }
}


############################################
# PUBLIC ROUTE ASSOCIATION
############################################
resource "aws_route_table_association" "xss_public_route1" {
  subnet_id                         = aws_subnet.xss_subnet1_useast1.id
  route_table_id                    = data.aws_route_table.openlxp_internet_route.id
}

