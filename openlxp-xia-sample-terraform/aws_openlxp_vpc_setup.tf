#####################################################
# VPC configuration for openlxp-ecc
#####################################################

provider "aws" {
  region                    = var.region
}
####################################
# openlxp-ecc VPC in us-east-1
####################################
resource "aws_vpc" "openlxp_ecc_vpc" {
  provider                  = aws
  cidr_block                = var.vpc_cidr_block
  enable_dns_support        = true
  enable_dns_hostnames      = true
  tags = {
    Name                    = var.vpc_name
  }
}

####################################
# IGW in us-east-1
####################################
resource "aws_internet_gateway" "openlxp-igw" {
  provider                  = aws
  vpc_id                    = aws_vpc.openlxp_ecc_vpc.id

  tags = {
    Name                    = var.vpc_igw
  }
}

##############################################
# Available AZ's in VPC for management region
##############################################
data "aws_availability_zones" "openlxp-azs" {
  provider                  = aws
  state                     = "available"
}

####################################
# route table in us-east-1
####################################
resource "aws_route_table" "openlxp_internet_route" {
  provider                  = aws
  vpc_id                    = aws_vpc.openlxp_ecc_vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.openlxp-igw.id
  }
  tags = {
    Name                    = var.vpc_route_table
  }
}


