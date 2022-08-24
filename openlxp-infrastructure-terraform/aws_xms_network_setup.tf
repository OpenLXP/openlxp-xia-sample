##############################################################
# AWS NETWORK CONFIG FOR:
# EXPERIENCE MANAGEMENT SERVICE (XMS)
# EXPERIENCE MANAGEMENT SERVICE UI (XMS-UI)
##############################################################
##################################
# subnet1 in us-east-1
##################################
resource "aws_subnet" "xms_subnet1_useast1" {
  provider                          = aws
  availability_zone                 = local.vpc.vpc_AZ
  vpc_id                            = data.aws_vpc.openlxp_vpc.id
  cidr_block                        = local.xms.subnet1_cidr_block
  map_public_ip_on_launch           = true
  tags = {
    Name                            = local.xms.subnet1_name
  }
}

############################################
# associate subnet with public route table
############################################
resource "aws_route_table_association" "xms_public_route1" {
  subnet_id                         = aws_subnet.xms_subnet1_useast1.id
  route_table_id                    = data.aws_route_table.openlxp_internet_route.id
}

