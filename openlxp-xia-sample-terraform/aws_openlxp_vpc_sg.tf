##################################################################
# VPC SG FOR: OPENLXP_ECC
##################################################################
resource "aws_security_group" "openlxp_vpc_sg" {
  name                      = var.vpc_sg_name
  description               = "Allow TLS inbound traffic on ports 8000,8010,8020,443"
  vpc_id                    = aws_vpc.openlxp_ecc_vpc.id

  ingress {
    description             = "All Traffic"
    from_port               = 0
    to_port                 = 65535
    protocol                = "tcp"
    self                    = true
  }

  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  tags = {
    Name                    = var.vpc_sg_name
  }
}